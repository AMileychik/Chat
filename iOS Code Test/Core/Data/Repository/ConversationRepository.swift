//
//  ConversationRepository.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

final class ConversationRepository: ConversationRepositoryProtocol {

    private let storage: ConversationsLocalStorageProtocol
    private var cache: [Conversation] = []

    init(storage: ConversationsLocalStorageProtocol) {
        self.storage = storage
    }

    // MARK: - Private

    /// Load conversations into cache if empty
    private func ensureCacheLoaded() async throws {
        if cache.isEmpty {
            cache = try await storage.loadConversations()
        }
    }

    // MARK: - Public

    /// Fetch all conversations
    func fetchConversations() async throws -> [Conversation] {
        let conversations = try await storage.loadConversations()
        cache = conversations
        return conversations
    }

    /// Add a message to a conversation
    func addMessage(text: String, to conversationId: String) async throws -> Conversation? {
        try await ensureCacheLoaded()

        guard let index = cache.firstIndex(where: { $0.id == conversationId }) else { return nil }

        let now = Date()
        let newMessage = Message(id: UUID().uuidString, text: text, lastUpdated: now)

        cache[index].messages.append(newMessage)
        cache[index].lastUpdated = now

        try await storage.saveConversations(cache)
        return cache[index]
    }

    /// Delete a message from a conversation
    func deleteMessage(messageId: String, from conversationId: String) async throws -> Conversation? {
        try await ensureCacheLoaded()

        guard let index = cache.firstIndex(where: { $0.id == conversationId }) else { return nil }
        guard let msgIndex = cache[index].messages.firstIndex(where: { $0.id == messageId }) else { return nil }

        cache[index].messages.remove(at: msgIndex)
        cache[index].lastUpdated = Date()

        try await storage.saveConversations(cache)
        return cache[index]
    }
}
