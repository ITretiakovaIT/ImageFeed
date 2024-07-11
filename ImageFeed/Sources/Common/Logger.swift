//
//  Logger.swift
//  ImageFeed
//
//  Created by Ira Tretiakova on 11.07.2024.
//

import Foundation

enum LogCategory: String, CaseIterable {
    case Network
}

struct Logger {
    static func debugLog(_ message: String = "", category: LogCategory) {
        #if DEBUG
        debugPrint("\(category.rawValue.uppercased()): \(message) \n")
        #endif
    }

    static func errorDebugLog(_ message: String = "", category: LogCategory) {
        let errorMessage = "Error: " + message
        debugLog(errorMessage, category: category)
    }
}
