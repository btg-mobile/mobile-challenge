//
//  RequestError.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

public protocol RequestError: LocalizedError {
    var title: String? { get }
}

public struct NotURLError: RequestError {
    public var title: String?
    public var errorDescription: String? { return _description }
    public var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid parse to URL."
        self._description = description
    }
}

public struct InvalidCodableError: RequestError {
    public var title: String?
    public var errorDescription: String? { return _description }
    public var failureReason: String? { return _description }

    private var _description: String

    init(title: String?, description: String) {
        self.title = title ?? "Invalid Codable Object."
        self._description = description
    }
}
