//
//  ViewModelFactory.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

final class ViewModelFactory: ViewModelFactoryProtocol {

    private let container: DependencyContainerProtocol

    init(container: DependencyContainerProtocol) {
        self.container = container
    }

    // MARK: - ViewModels

    /// Build inbox view model using repository from container
    @MainActor
    func makeInboxViewModel() -> InboxViewModelProtocol {
        InboxViewModel(repository: container.repository)
    }
}
