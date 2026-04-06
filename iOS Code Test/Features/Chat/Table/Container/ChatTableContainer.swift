//
//  ChatTableContainer.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Chat Table Container Protocol
protocol ChatTableContainerProtocol: AnyObject {
    func reloadData()
    func scrollToBottom()
}

// MARK: - Chat Table Container
final class ChatTableContainer: UIView, ChatTableContainerProtocol {

    // MARK: - UI
    public private(set) var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Dependencies
    private let controller: ChatTableControllerProtocol

    // MARK: - State
    private var messagesCount: Int = 0

    // MARK: - Init
    init(controller: ChatTableControllerProtocol) {
        self.controller = controller
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        bindController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views
    private func setupViews() {
        addSubview(tableView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Bind Controller
    private func bindController() {
        tableView.dataSource = controller.dataSource
        tableView.delegate = controller.delegate
        controller.registerCells(in: tableView)
        controller.configure(tableView: tableView)
    }

    // MARK: - Public Methods
    func reloadData() {
        tableView.reloadData()
    }

    func scrollToBottom() {
        let rows = tableView.numberOfRows(inSection: 0)
        guard rows > 0 else { return }
        let indexPath = IndexPath(row: rows - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}
