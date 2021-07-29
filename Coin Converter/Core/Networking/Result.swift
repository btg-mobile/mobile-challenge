//
//  Result.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

enum Result {
    case success(data: Data)
    case failure(error: Error)
}
