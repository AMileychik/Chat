//
//  ViewModelFactoryProtocol.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import UIKit

protocol ViewModelFactoryProtocol: AnyObject {
    func makeInboxViewModel() -> InboxViewModelProtocol
}
