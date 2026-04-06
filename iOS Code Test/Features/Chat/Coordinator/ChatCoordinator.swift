//
//  ChatCoordinator.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Chat Coordinator
final class ChatCoordinator {

    // MARK: - Properties
    private let navigationController: UINavigationController
    private let dependencies: AppDependenciesProtocol
    private let conversationId: String

    // MARK: - Init
    init(
        navigationController: UINavigationController,
        dependencies: AppDependenciesProtocol,
        conversationId: String
    ) {
        self.navigationController = navigationController
        self.dependencies = dependencies
        self.conversationId = conversationId
    }

    // MARK: - Start
    @MainActor
    func start() {
        // ViewModel
        let chatVM = ChatViewModel(
            conversationId: conversationId,
            repository: dependencies.diContainer.repository
        )

        // Table Adapter + Manager
        let tableAdapter = ChatTableAdapter(viewModel: chatVM)
        let tableManager = ChatTableManager()
        tableManager.onDeleteMessage = { [weak chatVM] indexPath in
            guard let messageId = chatVM?.messages[indexPath.row].id else { return }
            chatVM?.deleteMessage(messageId: messageId)
        }

        // Table Controller + Container
        let tableController = ChatTableController(adapter: tableAdapter, manager: tableManager)
        let tableContainer = ChatTableContainer(controller: tableController)

        // Input
        let inputContainer = ChatInputContainer()

        // Screen
        let chatVC = ChatViewController(
            tableContainer: tableContainer,
            inputContainer: inputContainer,
            viewModel: chatVM
        )

        // Navigation
        navigationController.pushViewController(chatVC, animated: true)
    }
}
