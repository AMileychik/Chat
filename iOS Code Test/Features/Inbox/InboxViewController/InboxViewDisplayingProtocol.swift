//
//  InboxViewDisplayingProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

protocol InboxViewDisplayingProtocol: AnyObject {
    var refreshControl: UIRefreshControl { get }
    var reloadHandler: (() -> Void)? { get set }
    
    func configureRefreshControl()
    func showLoading()
    func hideLoading()
    func reloadContent()
    func stopRefreshing()
    func showError(message: String)
}
