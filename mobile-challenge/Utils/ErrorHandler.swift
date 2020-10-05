//
//  ErrorHandler.swift
//  mobile-challenge
//
//  Created by Brunno Andrade on 04/10/20.
//

import Foundation

enum ErrorHandler: Error {
    
}

enum ErrorNetwork: Error {
    case decodingError
    case urlError
    case connectionError
    case failure
}
