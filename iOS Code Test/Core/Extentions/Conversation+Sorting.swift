//
//  Conversation+Sorting.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - Conversation sorting
extension Array where Element == Conversation {
    /// Sort conversations by newest first for inbox display
    func sortedForInbox() -> [Conversation] {
        self.sorted { $0.lastUpdated > $1.lastUpdated }
    }
}

// MARK: - Message sorting
extension Array where Element == Message {
    /// Sort messages by oldest first for chat display
    func sortedForChat() -> [Message] {
        self.sorted { $0.lastUpdated < $1.lastUpdated }
    }
}
