//
//  InboxCellBuilder.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox Cell Builder
final class InboxCellBuilder: InboxCellBuilding {
    
    // MARK: - Build Cell
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        model: InboxRowModel,
        actionHandler: InboxCellActionHandlerProtocol?
    ) -> UITableViewCell {
        
        // Only handle conversation row
        guard case .conversation(let conversation) = model else {
            return UITableViewCell()
        }
        
        // Dequeue reusable cell
        let cell: InboxCell = tableView.dequeueCell(indexPath)
        
        // Configure cell with model
        cell.configure(with: conversation)
        
        // Bind action handler
        cell.onAction = { action in
            actionHandler?.handle(action, at: indexPath)
        }
        
        return cell
    }
}
