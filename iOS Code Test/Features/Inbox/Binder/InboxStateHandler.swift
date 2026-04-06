//
//  InboxStateHandler.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

// MARK: - Inbox State Handler Protocol
protocol InboxStateHandlerProtocol {
    func bind()
}

// MARK: - Inbox State Handler
final class InboxStateHandler: InboxStateHandlerProtocol {

    // MARK: - Dependencies
    private let output: InboxViewModelProtocol
    private let view: InboxViewDisplayingProtocol?

    // MARK: - Init
    init(output: InboxViewModelProtocol, view: InboxViewDisplayingProtocol) {
        self.output = output
        self.view = view
    }

    // MARK: - Bind State
    @MainActor
    func bind() {
        output.onStateChanged = { [weak self] state in
            self?.handleState(state)
        }
    }

    // MARK: - Handle State Changes
    @MainActor
    private func handleState(_ state: ViewModelState) {
        switch state {
        case .initial:
            break

        case .loading:
            view?.showLoading()

        case .loaded:
            view?.hideLoading()
            view?.stopRefreshing()
            view?.reloadContent()

        case .error(let error):
            view?.hideLoading()
            view?.stopRefreshing()
            view?.showError(message: error.localizedDescription)
        }
    }
}
