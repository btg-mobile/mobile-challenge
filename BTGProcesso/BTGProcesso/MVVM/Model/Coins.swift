//
//  Coins.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 08/12/20.
//

import Foundation


struct Coins {
    var success: Bool
    var coins: [String: String]
    
}

extension Coins {
    enum CodingKeys: String, CodingKey {
        case coins = "currencies"
    }
}
