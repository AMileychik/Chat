//
//  InboxEffectHandler.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox Effect Handler Protocol
protocol InboxEffectHandlerProtocol {
    func bind()
}

// MARK: - Inbox Effect Handler
final class InboxEffectHandler: InboxEffectHandlerProtocol {

    // MARK: - Dependencies
    private let output: InboxViewModelProtocol
    private let coordinator: InboxCoordinator?

    // MARK: - Init
    init(output: InboxViewModelProtocol, coordinator: InboxCoordinator) {
        self.output = output
        self.coordinator = coordinator
    }

    // MARK: - Bind Effects
    @MainActor
    func bind() {
        output.onEffect = { [weak self] effect in
            self?.handleEffect(effect)
        }
    }

    // MARK: - Handle Effects
    @MainActor
    private func handleEffect(_ effect: ViewModelEffect) {
        switch effect {
        case .openChat(let conversation):
            coordinator?.openChat(with: conversation)
        }
    }
}
