//
//  ChatTableManagerProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

protocol ChatTableManagerProtocol: UITableViewDelegate {
    var onSelectRow: ((IndexPath) -> Void)? { get set }
    var onDeleteMessage: ((IndexPath) -> Void)? { get set }
    
    func registerCells(for tableView: UITableView)
}
