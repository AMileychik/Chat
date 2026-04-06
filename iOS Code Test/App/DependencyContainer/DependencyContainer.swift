//
//  DependencyContainer.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - DependencyContainerProtocol
protocol DependencyContainerProtocol: AnyObject {
    var repository: ConversationRepositoryProtocol { get }
}

// MARK: - DependencyContainer Implementation
final class DependencyContainer: DependencyContainerProtocol {
    
    // MARK: - Public Properties
    let repository: ConversationRepositoryProtocol
    
    // MARK: - Initializer
    init(repository: ConversationRepositoryProtocol) {
        self.repository = repository
    }
}
