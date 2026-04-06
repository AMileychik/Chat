//
//  InboxCoordinator.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - InboxCoordinator
final class InboxCoordinator {
    
    // MARK: - Dependencies
    private let dependencies: AppDependenciesProtocol
    
    // MARK: - Private Properties
    private var binder: InboxBinder?
    private var rootViewController: UIViewController?
    private(set) var navigationController: UINavigationController?
    
    // MARK: - Initializer
    init(dependencies: AppDependenciesProtocol) {
        self.dependencies = dependencies
    }
    
    // MARK: - Public Methods
    @MainActor
    func start() -> UIViewController  {
        // MARK: ViewModel
        let viewModel = dependencies.viewModelFactory.makeInboxViewModel()
        
        // MARK: Table Manager
        let manager = InboxTableViewManager()
        
        // MARK: Screen
        let inboxViewController = dependencies.screenFactory
            .makeInboxScreen(viewModel: viewModel, manager: manager)
        
        // MARK: Binder Layers
        let viewBinder = InboxViewBinder(
            viewModel: viewModel,
            manager: manager,
            inboxViewController: inboxViewController
        )
        
        let stateHandler = InboxStateHandler(
            output: viewModel,
            view: inboxViewController
        )
        
        let effectHandler = InboxEffectHandler(
            output: viewModel,
            coordinator: self
        )
        
        // MARK: Main Binder
        let binder = InboxBinder(
            viewBinder: viewBinder,
            stateHandler: stateHandler,
            effectHandler: effectHandler
        )
        binder.bind()
        self.binder = binder
        
        // MARK: Reload Handler
        inboxViewController.reloadHandler = { [weak viewModel] in
            Task { @MainActor in
                viewModel?.load()
            }
        }
        
        // MARK: Navigation Controller Setup
        let navController = UINavigationController(rootViewController: inboxViewController)
        self.navigationController = navController
        rootViewController = inboxViewController
        
        return navController
    }
}

// MARK: - Navigation Actions
extension InboxCoordinator {
    
    @MainActor
    func openChat(with conversation: Conversation) {
        guard let navController = navigationController else { return }

        let chatCoordinator = ChatCoordinator(
            navigationController: navController,
            dependencies: dependencies,
            conversationId: conversation.id
        )
        
        chatCoordinator.start()
    }
}
