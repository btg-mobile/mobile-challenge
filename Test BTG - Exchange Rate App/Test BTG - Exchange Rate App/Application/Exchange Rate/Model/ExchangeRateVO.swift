//
//  ExchangeRateVO.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

struct ExchangeRateVO: Codable {
    var success: Bool
    var source: String
    var quotes: [String: Double]
}
