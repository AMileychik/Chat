//
//  InboxCellBuilding.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

protocol InboxCellBuilding {
    func buildCell(
        in tableView: UITableView,
        indexPath: IndexPath,
        model: InboxRowModel,
        actionHandler: InboxCellActionHandlerProtocol?) -> UITableViewCell
}
