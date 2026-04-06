//
//  TableViewContainerProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

public protocol TableViewContainerProtocol: AnyObject {
    var refreshControl: UIRefreshControl? { get set }
    func reloadData()
}
