//
//  CurrencyModel.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

struct CurrencyModel: Decodable {
    let code: String
    let name: String
    var date: Date?
    var valueDollar: Double?
    
}
