//
//  InboxCellActionHandlerProtocol.swift
//  iOS Code Test
//
//  Created by Александр Милейчик on 4/6/26.
//

import Foundation

// MARK: - Action Handler Protocol
protocol InboxCellActionHandlerProtocol: AnyObject {
    /// Handle action for a given index path
    func handle(_ action: CellActions, at indexPath: IndexPath)
}
