//
//  InboxTableControllerProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

protocol InboxTableControllerProtocol {
    var dataSource: UITableViewDataSource { get }
    var delegate: UITableViewDelegate { get }
    
    func registerCells(in tableView: UITableView)
    func configure(tableView: UITableView)
}
