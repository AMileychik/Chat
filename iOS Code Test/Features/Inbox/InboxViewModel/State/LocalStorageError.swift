//
//  LocalStorageError.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

enum LocalStorageError: Error {
    case fileNotFound
    case failedToLoadSeed
    case decodingFailed
    case encodingFailed
    case writeFailed
}
