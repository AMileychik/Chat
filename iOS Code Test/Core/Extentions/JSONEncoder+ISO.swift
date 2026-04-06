//
//  JSONEncoder+ISO.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - JSONEncoder
extension JSONEncoder {
    /// Encoder with ISO8601 date support
    static func iso8601Encoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted] // Human-readable JSON
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let string = ISO8601DateFormatter.shared.string(from: date) // ISO8601 string
            try container.encode(string)
        }
        return encoder
    }
}
