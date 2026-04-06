//
//  InboxTableAdapter.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox Table Adapter
final class InboxTableAdapter: NSObject, UITableViewDataSource {
    
    // MARK: - Dependencies
    let viewModel: InboxViewModelProtocol
    private let cellBuilder: InboxCellBuilding
    let actionHandler: InboxCellActionHandlerProtocol
    
    // MARK: - Init
    init(
        viewModel: InboxViewModelProtocol,
        cellBuilder: InboxCellBuilding,
        actionHandler: InboxCellActionHandlerProtocol
    ) {
        self.viewModel = viewModel
        self.cellBuilder = cellBuilder
        self.actionHandler = actionHandler
    }
    
    // MARK: - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1 // Each section has one row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let conversation = viewModel.section(at: indexPath.section) else {
            assertionFailure("Section at index \(indexPath.section) does not exist")
            return UITableViewCell(style: .default, reuseIdentifier: "Fallback")
        }
        
        let model: InboxRowModel = .conversation(conversation)
        
        return cellBuilder.buildCell(
            in: tableView,
            indexPath: indexPath,
            model: model,
            actionHandler: actionHandler
        )
    }
}
