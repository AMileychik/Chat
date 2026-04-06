//
//  ScreenFactoryProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

protocol ScreenFactoryProtocol: AnyObject {
    func makeInboxScreen(viewModel: InboxViewModelProtocol, manager: InboxTableViewManagerProtocol) -> UIViewController & InboxViewDisplayingProtocol
}
