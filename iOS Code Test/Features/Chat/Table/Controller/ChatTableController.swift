//
//  File.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Chat Table Controller
final class ChatTableController: NSObject, ChatTableControllerProtocol {

    // MARK: - Properties
    let adapter: ChatTableAdapter
    let manager: ChatTableManagerProtocol

    // MARK: - Init
    init(adapter: ChatTableAdapter, manager: ChatTableManagerProtocol) {
        self.adapter = adapter
        self.manager = manager
        super.init()
    }

    // MARK: - Data Source & Delegate
    var dataSource: UITableViewDataSource { adapter }
    var delegate: UITableViewDelegate { manager }

    // MARK: - Cell Registration
    func registerCells(in tableView: UITableView) {
        manager.registerCells(for: tableView)
    }

    // MARK: - Table Configuration
    func configure(tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .interactive
        tableView.backgroundColor = .systemBackground
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
}
