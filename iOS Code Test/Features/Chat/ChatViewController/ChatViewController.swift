//
//  ChatViewController.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

final class ChatViewController: UIViewController {

    // MARK: - UI
    private let tableContainer: UIView & ChatTableContainerProtocol
    private let inputContainer: ChatInputContainer

    // MARK: - ViewModel
    private let viewModel: ChatViewModelProtocol

    // MARK: - Init
    init(
        tableContainer: UIView & ChatTableContainerProtocol,
        inputContainer: ChatInputContainer,
        viewModel: ChatViewModelProtocol
    ) {
        self.tableContainer = tableContainer
        self.inputContainer = inputContainer
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        setupViews()
        setupConstraints()
        bindViewModel()
        bindInput()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Load messages on appear
        Task { @MainActor in
            await viewModel.loadConversation()
        }
    }

    // MARK: - Actions
    @objc private func sendTapped() {
        guard let text = inputContainer.inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else { return }
        viewModel.sendMessage(text: text)
        inputContainer.inputTextField.text = ""
        inputContainer.sendButton.isEnabled = false
    }

    private func bindInput() {
        inputContainer.sendButton.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
    }

    // MARK: - ViewModel Binding
    private func bindViewModel() {
        // Refresh table on messages update
        viewModel.onUpdate = { [weak self] in
            self?.tableContainer.reloadData()
            DispatchQueue.main.async { self?.tableContainer.scrollToBottom() }
        }

        // Show errors
        viewModel.onError = { [weak self] message in
            self?.showAlert(message: message)
        }
    }

    // MARK: - Helpers
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Layout
private extension ChatViewController {
    func setupViews() {
        view.addSubview(tableContainer)
        view.addSubview(inputContainer)
    }

    func setupConstraints() {
        tableContainer.translatesAutoresizingMaskIntoConstraints = false
        inputContainer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            inputContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputContainer.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor),

            tableContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableContainer.bottomAnchor.constraint(equalTo: inputContainer.topAnchor)
        ])
    }
}
