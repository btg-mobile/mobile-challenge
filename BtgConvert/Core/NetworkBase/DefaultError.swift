//
//  DefaultError.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 29/04/21.
//

import Foundation

public struct DefaultError: Codable {
    public var statusCode: Int
    public let message: String
}

class ResponseError: Error {
    let code: Int
    let message: String
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
