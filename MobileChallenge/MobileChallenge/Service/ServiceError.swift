//
//  ServiceError.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

enum ServiceError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case requestError
}
