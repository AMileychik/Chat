//
//  ScreenFactory.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

final class ScreenFactory: ScreenFactoryProtocol {

    // MARK: - Helpers

    /// Standard refresh control
    public func makeRefreshControl() -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .gray
        return refreshControl
    }
    
    /// Activity indicator with optional style/color
    public func makeActivityIndicator(
        style: UIActivityIndicatorView.Style = .large,
        color: UIColor = .black
    ) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }
    
    // MARK: - Screens

    /// Build inbox screen
    func makeInboxScreen(viewModel: InboxViewModelProtocol, manager: InboxTableViewManagerProtocol) -> UIViewController & InboxViewDisplayingProtocol {
        let contentView = makeTableContainer(for: viewModel, manager: manager)
        let refreshControl = makeRefreshControl()
        let activityIndicator = makeActivityIndicator()
        
        return InboxViewController(contentView: contentView, refreshControl: refreshControl, activityIndicator: activityIndicator)
    }

    // MARK: - Table Container

    /// Wrap table controller in container
    func makeTableContainer(for viewModel: InboxViewModelProtocol, manager: InboxTableViewManagerProtocol) -> TableViewContainer {
        let controller = makeController(for: viewModel, manager: manager)
        return TableViewContainer(controller: controller)
    }

    // MARK: - Table Controller

    /// Build table controller with adapter and manager
    private func makeController(for viewModel: InboxViewModelProtocol, manager: InboxTableViewManagerProtocol) -> InboxTableController {
        let adapter = makeAdapter(for: viewModel)
        return InboxTableController(adapter: adapter, manager: manager)
    }

    // MARK: - Adapter

    /// Build table adapter with cell builder & action handler
    private func makeAdapter(for viewModel: InboxViewModelProtocol) -> InboxTableAdapter {
        let cellBuilder = InboxCellBuilder()
        let actionHandler = InboxCellActionHandler(viewModel: viewModel)
        return InboxTableAdapter(
            viewModel: viewModel,
            cellBuilder: cellBuilder,
            actionHandler: actionHandler
        )
    }
}
