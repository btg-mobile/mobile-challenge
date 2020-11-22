//
//  NetworkError.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

enum NetworkError: Error {
    case APIOffline
    case unknownError
    case invalidURL
    case APIError
    case noConnection
    case decodeFailure
}
