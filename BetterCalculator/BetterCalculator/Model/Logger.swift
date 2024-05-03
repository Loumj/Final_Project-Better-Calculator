//
//  Logger.swift
//  BetterCalculator
//
//  Created by  on 5/3/24.
//

import Foundation

class Logger {
    static let shared = Logger() // Singleton instance
    private(set) var logs: [String] = []

    var logUpdateHandler: (() -> Void)?

    func log(_ message: String) {
        let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .medium)
        let logMessage = "\(timestamp): \(message)"
        
        logs.append(logMessage)
        
        // Notify observer that a new log has been added
        logUpdateHandler?()
    }
}
