//
//  CurrencieModel.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import ObjectMapper

// MARK: Initializer and Properties
struct CurrencieModel: Mappable {
    var name: String!
    var value: Double!
    
    // MARK: JSON
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        value <- map["value"]
    }
}
