//
//  InboxBinder.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - Inbox Binder Protocol
protocol InboxBinderProtocol: AnyObject {
    func bind()
}

// MARK: - Inbox Binder
final class InboxBinder: InboxBinderProtocol {

    // MARK: - Dependencies
    private let viewBinder: InboxViewBinderProtocol
    private let stateHandler: InboxStateHandlerProtocol
    private let effectHandler: InboxEffectHandlerProtocol

    // MARK: - Init
    init(
        viewBinder: InboxViewBinderProtocol,
        stateHandler: InboxStateHandlerProtocol,
        effectHandler: InboxEffectHandlerProtocol
    ) {
        self.viewBinder = viewBinder
        self.stateHandler = stateHandler
        self.effectHandler = effectHandler
    }

    // MARK: - Bind All Layers
    func bind() {
        stateHandler.bind()
        effectHandler.bind()
        viewBinder.bind()
    }
}
