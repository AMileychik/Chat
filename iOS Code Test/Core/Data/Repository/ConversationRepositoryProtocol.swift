//
//  ConversationRepositoryProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

protocol ConversationRepositoryProtocol {
    func fetchConversations() async throws -> [Conversation]
    func addMessage(text: String, to conversationId: String) async throws -> Conversation?
    func deleteMessage(messageId: String, from conversationId: String) async throws -> Conversation?
}
