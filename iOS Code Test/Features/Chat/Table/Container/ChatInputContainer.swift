//
//  ChatInputContainer.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Chat Input Container
final class ChatInputContainer: UIView {

    // MARK: - UI Elements
    private let backgroundCard: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 20
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.separator.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Blinkie")
        return iv
    }()

    private(set) lazy var inputTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.placeholder = "Message"
        field.font = .systemFont(ofSize: 16)
        field.borderStyle = .none
        field.clearButtonMode = .whileEditing
        field.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return field
    }()

    private(set) lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "paperplane.fill")
        button.setImage(image, for: .normal)
        button.tintColor = .systemBlue
        button.isEnabled = false
        button.alpha = 0.4
        return button
    }()

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        addSubview(backgroundCard)
        backgroundCard.addSubview(logoImageView)
        backgroundCard.addSubview(inputTextField)
        backgroundCard.addSubview(sendButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 74),

            backgroundCard.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            backgroundCard.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            backgroundCard.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backgroundCard.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),

            logoImageView.leadingAnchor.constraint(equalTo: backgroundCard.leadingAnchor, constant: 12),
            logoImageView.centerYAnchor.constraint(equalTo: backgroundCard.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalTo: backgroundCard.heightAnchor, multiplier: 0.8),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),

            sendButton.trailingAnchor.constraint(equalTo: backgroundCard.trailingAnchor, constant: -12),
            sendButton.centerYAnchor.constraint(equalTo: backgroundCard.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 34),
            sendButton.heightAnchor.constraint(equalToConstant: 34),

            inputTextField.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10),
            inputTextField.centerYAnchor.constraint(equalTo: backgroundCard.centerYAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 36)
        ])
    }

    // MARK: - Actions
    @objc private func textDidChange() {
        let trimmed = inputTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let enabled = !trimmed.isEmpty
        sendButton.isEnabled = enabled
        sendButton.alpha = enabled ? 1.0 : 0.4
    }
}
