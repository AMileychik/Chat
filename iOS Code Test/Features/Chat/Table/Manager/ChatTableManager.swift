//
//  ChatTableManager.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Chat Table Manager
final class ChatTableManager: NSObject, ChatTableManagerProtocol {

    // MARK: - Callbacks
    var onSelectRow: ((IndexPath) -> Void)?
    var onDeleteMessage: ((IndexPath) -> Void)?

    // MARK: - Cell Registration
    func registerCells(for tableView: UITableView) {
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: "ChatMessageCell")
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        onSelectRow?(indexPath)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.onDeleteMessage?(indexPath)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
