//
//  CacheError.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

/// List of possible errors when interacting with
/// `Cache`.
enum CacheError: Error {
    case failedToSave
    case failedToLoad
    case encodingFailed
    case unexpectedType
}

extension CacheError {
    var description: String {
        switch self {
        case .failedToSave:
            return "Failed to save to cache."
        case .failedToLoad:
            return "Failed to load from cache."
        case .encodingFailed:
            return "Failed to encode response."
        case .unexpectedType:
            return "Unexpected encodable type."
        }
    }
}
