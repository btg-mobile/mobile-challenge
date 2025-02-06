//
//  CurrencyError.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

enum CurrencyServiceError: Error {
    case notFound (String = "404: Not Found")
    case unknown(String = "Unknown error")
    case decodingError(String = "Error parsing server response.")
}
