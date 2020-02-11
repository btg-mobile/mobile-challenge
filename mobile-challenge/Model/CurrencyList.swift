//
//  CurrencyList.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

struct CurrencyList: Codable {
    
    let success: Bool?
    let terms, privacy: String?
    let currencies: [String: String]?

}
