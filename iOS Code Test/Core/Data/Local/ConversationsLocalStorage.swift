//
//  ConversationsLocalStorage.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

final class ConversationsLocalStorage: ConversationsLocalStorageProtocol {

    private let fileName = "conversations.json"

    // MARK: - File URL
    private var fileURL: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent(fileName)
    }

    // MARK: - Load
    /// Load conversations from disk or seed bundle if missing
    func loadConversations() async throws -> [Conversation] {
        try await Task.detached(priority: .utility) { [fileURL] in

            // Load from disk if available
            if FileManager.default.fileExists(atPath: fileURL.path) {
                let data = try Data(contentsOf: fileURL)
                let dto = try JSONDecoder.iso8601Decoder().decode([ConversationDTO].self, from: data)
                return dto.map { $0.toDomain() }
            }

            // Load seed from bundle
            guard let seedURL = Bundle.main.url(forResource: "code_test_data", withExtension: "json") else {
                print("Bundle file not found")
                throw LocalStorageError.failedToLoadSeed
            }

            do {
                let seedData = try Data(contentsOf: seedURL)
                let dto = try JSONDecoder.iso8601Decoder().decode([ConversationDTO].self, from: seedData)
                print("Loaded DTO from bundle: \(dto)")

                // Persist seed to disk
                try seedData.write(to: fileURL, options: [.atomic])

                return dto.map { $0.toDomain() }
            } catch {
                print("Failed decoding JSON: \(error)")
                throw error
            }

        }.value
    }

    // MARK: - Save
    /// Save conversations to disk
    func saveConversations(_ conversations: [Conversation]) async throws {
        try await Task.detached(priority: .utility) { [fileURL] in

            let dto: [ConversationDTO] = conversations.map {
                ConversationDTO(
                    id: $0.id,
                    name: $0.name,
                    last_updated: ISO8601DateFormatter().string(from: $0.lastUpdated), // Convert Date → String
                    messages: $0.messages.map {
                        MessageDTO(
                            id: $0.id,
                            text: $0.text,
                            last_updated: ISO8601DateFormatter().string(from: $0.lastUpdated)
                        )
                    }
                )
            }

            let data = try JSONEncoder.iso8601Encoder().encode(dto)

            do {
                try data.write(to: fileURL, options: [.atomic])
            } catch {
                throw LocalStorageError.writeFailed
            }

        }.value
    }
}
