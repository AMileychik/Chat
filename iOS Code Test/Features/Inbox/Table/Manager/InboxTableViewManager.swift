//
//  TableViewManager.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox Table Manager
final class InboxTableViewManager: NSObject, UITableViewDelegate, InboxTableViewManagerProtocol {
    
    // MARK: - Callbacks
    var onSelectRow: ((IndexPath) -> Void)?
    
    // MARK: - Cell Registration
    func registerCells(for tableView: UITableView) {
        tableView.registerCell(InboxCell.self)
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectRow?(indexPath)
    }
}
