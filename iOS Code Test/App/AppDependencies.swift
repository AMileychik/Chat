//
//  AppDependencies.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - AppDependenciesProtocol
protocol AppDependenciesProtocol: AnyObject {
    var diContainer: DependencyContainerProtocol { get }
    var screenFactory: ScreenFactoryProtocol { get }
    var viewModelFactory: ViewModelFactoryProtocol { get }
}

// MARK: - AppDependencies Implementation
final class AppDependencies: AppDependenciesProtocol {
    
    // MARK: - Public Properties
    let diContainer: DependencyContainerProtocol
    let screenFactory: ScreenFactoryProtocol
    let viewModelFactory: ViewModelFactoryProtocol
    
    // MARK: - Initializer
    init() {
        // MARK: - Setup Local Storage
        let storage = ConversationsLocalStorage()
        
        // MARK: - Setup Repository
        let repository = ConversationRepository(storage: storage)
        
        // MARK: - Initialize Dependencies
        self.diContainer = DependencyContainer(repository: repository)
        self.screenFactory = ScreenFactory()
        self.viewModelFactory = ViewModelFactory(container: diContainer)
    }
}
