//
//  ConversationsLocalStorageProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

protocol ConversationsLocalStorageProtocol {
    func loadConversations() async throws -> [Conversation]
    func saveConversations(_ conversations: [Conversation]) async throws
}
