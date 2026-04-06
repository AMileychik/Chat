//
//  TableViewContainer.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - TableView Container
final class TableViewContainer: UIView {
    
    // MARK: - Subviews
    public private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Dependencies
    var controller: InboxTableControllerProtocol
    
    // MARK: - Init
    init(controller: InboxTableControllerProtocol) {
        self.controller = controller
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        bindController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Binding
    func bindController() {
        tableView.dataSource = controller.dataSource
        tableView.delegate = controller.delegate
        controller.registerCells(in: tableView)
        controller.configure(tableView: tableView)
    }
}

// MARK: - TableViewContainerProtocol
extension TableViewContainer: TableViewContainerProtocol {
    
    public var refreshControl: UIRefreshControl? {
        get { tableView.refreshControl }
        set { tableView.refreshControl = newValue }
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Layout
private extension TableViewContainer {
    
    func setupViews() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
