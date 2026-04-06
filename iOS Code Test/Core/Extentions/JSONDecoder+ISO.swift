//
//  JSONDecoder+ISO.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - JSONDecoder
extension JSONDecoder {
    /// Decoder with ISO8601 date support
    static func iso8601Decoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            // Try parsing as-is
            if let date = ISO8601DateFormatter.shared.date(from: string) {
                return date
            }
            // Fallback with appended "Z"
            if let date = ISO8601DateFormatter.shared.date(from: string + "Z") {
                return date
            }

            throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Invalid ISO8601 date: \(string)"
            )
        }
        return decoder
    }
}

// MARK: - ISO8601DateFormatter
extension ISO8601DateFormatter {
    /// Shared formatter instance
    static let shared: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime] // Default ISO8601
        return formatter
    }()
}
