//
//  ErrorType.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

enum ErrorType: LocalizedError {
    case parseUrlFail
    case notFound
    case badRequest
    case serverError
    case defaultError
    
    var errorDescription: String {
        switch self {
            case .parseUrlFail:
                return "Cannot init URL object."
            case .notFound:
                return "Not Found"
            case .badRequest:
                return "Bad request"
            case .serverError:
                return "Internal Server Error"
            case .defaultError:
                return "Something went wrong."
        }
    }
}
