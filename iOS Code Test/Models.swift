//
//  Models.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - Conversation DTO
struct ConversationDTO: Codable {
    let id: String
    let name: String
    let last_updated: String
    let messages: [MessageDTO]
    
    // MARK: - Mapping to Domain
    func toDomain() -> Conversation {
        Conversation(
            id: id,
            name: name,
            lastUpdated: ISO8601DateFormatter().date(from: last_updated) ?? Date(),
            messages: messages.map { $0.toDomain() }
        )
    }
}

// MARK: - Message DTO
struct MessageDTO: Codable {
    let id: String
    let text: String
    let last_updated: String
    
    // MARK: - Mapping to Domain
    func toDomain() -> Message {
        Message(
            id: id,
            text: text,
            lastUpdated: ISO8601DateFormatter().date(from: last_updated) ?? Date()
        )
    }
}

// MARK: - Conversation Domain Model
struct Conversation: Codable, Identifiable, Equatable {
    let id: String
    let name: String
    var lastUpdated: Date
    var messages: [Message]
}

// MARK: - Message Domain Model
struct Message: Codable, Identifiable, Equatable {
    let id: String
    let text: String
    let lastUpdated: Date
}

// MARK: - Inbox Cell Model
enum InboxRowModel {
    case conversation(Conversation)
}
