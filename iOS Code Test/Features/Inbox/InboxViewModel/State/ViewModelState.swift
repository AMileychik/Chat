//
//  ViewModelState.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

enum ViewModelState {
    case initial
    case loading
    case loaded
    case error(LocalStorageError)
}
