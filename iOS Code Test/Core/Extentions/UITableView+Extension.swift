//
//  UITableView+Extension.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - UITableView cell helpers
extension UITableView {
    
    /// Register a UITableViewCell subclass using its reuseId
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.reuseId)
    }
    
    /// Dequeue a reusable cell of the expected type
    func dequeueCell<Cell: UITableViewCell>(_ indexPath: IndexPath) -> Cell {
        guard let cell = dequeueReusableCell(withIdentifier: Cell.reuseId, for: indexPath) as? Cell else {
            fatalError("❌ Failed to dequeue cell of type \(Cell.self) with reuseId \(Cell.reuseId) at \(indexPath)")
        }
        return cell
    }
}

// MARK: - Reusable cell protocol
protocol Reusable: AnyObject {
    /// Unique reuse identifier
    static var reuseId: String { get }
}

extension Reusable {
    static var reuseId: String { String(describing: Self.self) }
}

// Make all UITableViewCell conform by default
extension UITableViewCell: Reusable {}
