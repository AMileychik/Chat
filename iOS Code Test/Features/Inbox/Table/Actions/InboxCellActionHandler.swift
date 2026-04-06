//
//  File.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox Cell Action Handler
final class InboxCellActionHandler: InboxCellActionHandlerProtocol {
    
    // MARK: - Properties
    private let viewModel: InboxViewModelProtocol
    
    // MARK: - Init
    init(viewModel: InboxViewModelProtocol) {
        self.viewModel = viewModel
    }
    
    // MARK: - Action Handling
    @MainActor
    func handle(_ action: CellActions, at indexPath: IndexPath) {
        switch action {
        case .inboxCellItemSelected(let conversation):
            viewModel.sendEvent(.openChat(conversation))
        }
    }
}
