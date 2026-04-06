//
//  InboxViewBinder.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox View Binder Protocol
protocol InboxViewBinderProtocol: AnyObject {
    func bind()
}

// MARK: - Inbox View Binder
final class InboxViewBinder: InboxViewBinderProtocol {

    // MARK: - Dependencies
    private let viewModel: InboxViewModelProtocol
    private let manager: InboxTableViewManagerProtocol
    private weak var inboxViewController: InboxViewDisplayingProtocol?

    // MARK: - Init
    init(
        viewModel: InboxViewModelProtocol,
        manager: InboxTableViewManagerProtocol,
        inboxViewController: InboxViewDisplayingProtocol
    ) {
        self.viewModel = viewModel
        self.manager = manager
        self.inboxViewController = inboxViewController
    }

    // MARK: - Binding
    @MainActor
    public func bind() {
        bindUserActions()
        viewModel.onAppear()
    }

    private func bindUserActions() {
        guard let viewController = inboxViewController else { return }

        // Pull-to-refresh
        viewController.refreshControl.addTarget(self, action: #selector(onRefreshTriggered), for: .valueChanged)
        viewController.configureRefreshControl()

        // Row selection
        manager.onSelectRow = { [weak self] indexPath in
            guard let self else { return }
            Task { @MainActor in
                guard let conversation = self.viewModel.section(at: indexPath.section) else { return }
                self.viewModel.sendEvent(.openChat(conversation))
            }
        }
    }

    // MARK: - Actions
    @MainActor
    @objc private func onRefreshTriggered() {
        viewModel.load()
    }
}
