//
//  HTTP.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import Foundation

enum HTTP {
    enum Method: String {
        case get = "GET"
    }
    enum Headers{
        enum Key: String {
            case contentType = "Content-Type"
        }
        enum Value: String {
            case json = "json"
        }
    }
}
