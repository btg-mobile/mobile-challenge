//
//  Response.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import Foundation

class GetResponse: Codable {
    var success: Bool?
    
    init(_ success: Bool? = nil) {
        self.success = success
    }
    
    enum CodingKeys: String, CodingKey {
        case success = "success"
    }
}
