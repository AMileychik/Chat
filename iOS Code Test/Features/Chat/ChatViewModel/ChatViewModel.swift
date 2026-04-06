//
//  ChatViewModel.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

@MainActor
final class ChatViewModel: ChatViewModelProtocol {

    // MARK: - State
    private(set) var conversation: Conversation?
    private let conversationId: String
    private let repository: ConversationRepositoryProtocol

    // MARK: - Callbacks
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?

    // MARK: - Init
    init(conversationId: String, repository: ConversationRepositoryProtocol) {
        self.conversationId = conversationId
        self.repository = repository
    }

    // MARK: - Loading
    /// Load conversation from repository
    func loadConversation() async {
        do {
            let conversations = try await repository.fetchConversations()
            if let conv = conversations.first(where: { $0.id == conversationId }) {
                conversation = conv
                onUpdate?()
            }
        } catch {
            onError?("Failed to load conversation")
        }
    }

    // MARK: - Messaging
    /// Send new message
    func sendMessage(text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        // Optimistic update
        let message = Message(id: UUID().uuidString, text: trimmed, lastUpdated: Date())
        conversation?.messages.append(message)
        onUpdate?()

        // Persist to repository
        Task {
            do {
                if let updated = try await repository.addMessage(text: trimmed, to: conversationId) {
                    conversation = updated
                    onUpdate?()
                }
            } catch {
                onError?("Failed to send message")
            }
        }
    }

    /// Delete a message by ID
    func deleteMessage(messageId: String) {
        guard var conversation = conversation else { return }

        // Optimistic removal
        if let index = conversation.messages.firstIndex(where: { $0.id == messageId }) {
            conversation.messages.remove(at: index)
            onUpdate?()
        }

        // Persist deletion
        Task {
            do {
                if let updated = try await repository.deleteMessage(messageId: messageId, from: conversationId) {
                    self.conversation = updated
                    onUpdate?()
                }
            } catch {
                onError?("Failed to delete message")
            }
        }
    }

    // MARK: - Computed
    /// Messages sorted for display
    var messages: [Message] {
        conversation?.messages.sortedForChat() ?? []
    }
}
