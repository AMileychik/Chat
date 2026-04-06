//
//  ViewController.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - InboxViewController

final class InboxViewController: UIViewController {
    
    // MARK: - UI Components
    private let contentView: UIView & TableViewContainerProtocol
    private let activityIndicator: UIActivityIndicatorView
    public let refreshControl: UIRefreshControl
    
    // MARK: - Callbacks
    var reloadHandler: (() -> Void)?
    
    // MARK: - Initializer
    init(
        contentView: UIView & TableViewContainerProtocol,
        refreshControl: UIRefreshControl,
        activityIndicator: UIActivityIndicatorView
    ) {
        self.contentView = contentView
        self.refreshControl = refreshControl
        self.activityIndicator = activityIndicator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Inbox"
        setupNavigationBar()
        setupViews()
        setupConstraints()
        setupActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadHandler?()
    }
    
    // MARK: - Private Helpers
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}

// MARK: - InboxViewDisplayingProtocol

extension InboxViewController: InboxViewDisplayingProtocol {
    
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
    }
    
    func configureRefreshControl() {
        contentView.refreshControl = refreshControl
    }
    
    func reloadContent() {
        contentView.reloadData()
    }
    
    func showError(message: String) {
        showAlert(message: message)
    }
    
    func stopRefreshing() {
        refreshControl.endRefreshing()
    }
}

// MARK: - Layout Setup

private extension InboxViewController {
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(contentView)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

