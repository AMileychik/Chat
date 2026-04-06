//
//  iOS_Code_TestTests.swift
//  iOS Code TestTests
//
//  Created by Alexander Mileychik on 4/6/26.
//

import XCTest
@testable import iOS_Code_Test

final class iOS_Code_TestTests: XCTestCase {

    // MARK: - Sorting Tests

    func testInboxSortingNewestFirst() {
        // Conversations should be sorted descending by lastUpdated
        let old = Conversation(id: "1", name: "Old", lastUpdated: Date(timeIntervalSince1970: 10), messages: [])
        let new = Conversation(id: "2", name: "New", lastUpdated: Date(timeIntervalSince1970: 20), messages: [])
        
        let sorted = [old, new].sortedForInbox()
        
        XCTAssertEqual(sorted.first?.id, "2")
    }

    func testChatSortingOldestFirst() {
        // Messages should be sorted ascending by lastUpdated
        let m1 = Message(id: "1", text: "Old", lastUpdated: Date(timeIntervalSince1970: 10))
        let m2 = Message(id: "2", text: "New", lastUpdated: Date(timeIntervalSince1970: 20))
        
        let sorted = [m2, m1].sortedForChat()
        
        XCTAssertEqual(sorted.first?.id, "1")
    }

    // MARK: - ViewModel Tests

    @MainActor
    func testViewModelOpenChatEvent() {
        // Verify .openChat event triggers the correct effect
        let repository = MockConversationRepository()
        let viewModel = InboxViewModel(repository: repository)
        
        var triggeredEffect: ViewModelEffect?
        viewModel.onEffect = { effect in
            triggeredEffect = effect
        }
        
        let conversation = Conversation(id: "123", name: "Test", lastUpdated: Date(), messages: [])
        viewModel.sendEvent(.openChat(conversation))
        
        XCTAssertNotNil(triggeredEffect)
        
        if case .openChat(let conv) = triggeredEffect! {
            XCTAssertEqual(conv.id, "123")
            XCTAssertEqual(conv.name, "Test")
        } else {
            XCTFail("Expected openChat effect")
        }
    }

    @MainActor
    func testAddAndDeleteMessage() async throws {
        // Ensure messages can be added and removed via repository
        let conversation = Conversation(id: "1", name: "Test", lastUpdated: Date(), messages: [])
        let repository = MockConversationRepositoryWithData(conversations: [conversation])
        
        let updated = try await repository.addMessage(text: "Hello", to: "1")
        XCTAssertEqual(updated?.messages.count, 1)
        
        let afterDelete = try await repository.deleteMessage(messageId: updated!.messages[0].id, from: "1")
        XCTAssertEqual(afterDelete?.messages.count, 0)
    }
}

// MARK: - Mock Repositories

@MainActor
final class MockConversationRepository: ConversationRepositoryProtocol {
    func fetchConversations() async throws -> [Conversation] { [] }
    func addMessage(text: String, to conversationId: String) async throws -> Conversation? { nil }
    func deleteMessage(messageId: String, from conversationId: String) async throws -> Conversation? { nil }
}

@MainActor
final class MockConversationRepositoryWithData: ConversationRepositoryProtocol {
    private var conversations: [Conversation]
    
    init(conversations: [Conversation]) { self.conversations = conversations }

    func fetchConversations() async throws -> [Conversation] { conversations }

    func addMessage(text: String, to conversationId: String) async throws -> Conversation? {
        guard let index = conversations.firstIndex(where: { $0.id == conversationId }) else { return nil }
        let newMessage = Message(id: UUID().uuidString, text: text, lastUpdated: Date())
        conversations[index].messages.append(newMessage)
        conversations[index].lastUpdated = Date()
        return conversations[index]
    }

    func deleteMessage(messageId: String, from conversationId: String) async throws -> Conversation? {
        guard let index = conversations.firstIndex(where: { $0.id == conversationId }) else { return nil }
        guard let msgIndex = conversations[index].messages.firstIndex(where: { $0.id == messageId }) else { return nil }
        conversations[index].messages.remove(at: msgIndex)
        conversations[index].lastUpdated = Date()
        return conversations[index]
    }
}
