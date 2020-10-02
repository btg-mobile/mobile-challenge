//
//  NetworkService.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import Foundation

/// The service responsible for performing network requests.
protocol NetworkService {
    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

enum NetworkServiceError: Error {
    case requestFailed
    case unexpectedHTTPResponse
    case decodingFailed
}

extension NetworkServiceError {
    var description: String {
        switch self {
        case .requestFailed:
            return "Request failed."
        case .unexpectedHTTPResponse:
            return "Received unexpected HTTP response."
        case .decodingFailed:
            return "Decoding failed."
        }
    }
}
