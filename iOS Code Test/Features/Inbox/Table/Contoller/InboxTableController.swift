//
//  InboxTableController.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox Table Controller
final class InboxTableController: NSObject, InboxTableControllerProtocol {
    
    // MARK: - Dependencies
    let adapter: InboxTableAdapter
    let manager: InboxTableViewManagerProtocol

    // MARK: - Init
    init(
        adapter: InboxTableAdapter,
        manager: InboxTableViewManagerProtocol
    ) {
        self.adapter = adapter
        self.manager = manager
        super.init()
    }
    
    // MARK: - DataSource & Delegate
    var dataSource: UITableViewDataSource { adapter }
    var delegate: UITableViewDelegate { manager }
    
    // MARK: - Cell Registration
    func registerCells(in tableView: UITableView) {
        manager.registerCells(for: tableView)
    }
    
    // MARK: - TableView Configuration
    func configure(tableView: UITableView) {
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .systemBackground
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
    }
}
