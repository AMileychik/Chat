//
//  InboxViewModel.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

@MainActor
final class InboxViewModel: InboxViewModelProtocol {

    // MARK: - Properties

    private(set) var conversations: [Conversation] = []
    private let repository: ConversationRepositoryProtocol

    var loadProductsTask: Task<Void, Never>? = nil

    var onEvent: ((ViewModelEvent) -> Void)?
    var onEffect: ((ViewModelEffect) -> Void)?
    var onStateChanged: ((ViewModelState) -> Void)?

    // MARK: - Init

    init(repository: ConversationRepositoryProtocol) {
        self.repository = repository
    }
}

// MARK: - Input

extension InboxViewModel {

    /// Called when view appears
    func onAppear() {
        onStateChanged?(.loading)
        load()
    }

    /// Load conversations from repository
    func load() {
        loadProductsTask?.cancel()

        loadProductsTask = Task {
            do {
                let data = try await repository.fetchConversations()
                conversations = data.sortedForInbox()
                onStateChanged?(.loaded)

            } catch is CancellationError {
                // ignore cancellation
            } catch {
                if conversations.isEmpty {
                    onStateChanged?(.error(LocalStorageError.failedToLoadSeed))
                } else {
                    onStateChanged?(.loaded)
                }
            }
        }
    }

    /// Handle UI events
    func sendEvent(_ action: ViewModelEvent) {
        switch action {
        case .openChat(let conversation):
            onEffect?(.openChat(conversation))
        case .refreshData:
            load()
        }
    }
}

// MARK: - Output

extension InboxViewModel {

    /// Number of sections
    func numberOfSections() -> Int {
        conversations.count
    }

    /// Get conversation for section
    func section(at index: Int) -> Conversation? {
        guard conversations.indices.contains(index) else { return nil }
        return conversations[index]
    }
}

