//
//  DateFormatter+Chat.swift
//  iOS Code Test
//
//  Created by Alexander Mileychik on 4/6/26.
//

import Foundation

// MARK: - Date formatting
extension DateFormatter {
    /// Formatter for chat message previews (e.g., "Apr 6, 2026, 3:45 PM")
    static let chatPreview: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .short
        return df
    }()
}
 
