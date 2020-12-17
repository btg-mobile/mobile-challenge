//
//  NetworkingError.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

enum NetworkingError: String, Error {
    case noDataReceived = "The request did not generate any data"
    case invalidURL = "Invalid URL"
    case unknown = "Something went wrong while trying to retrieve data from URLSession"
}
