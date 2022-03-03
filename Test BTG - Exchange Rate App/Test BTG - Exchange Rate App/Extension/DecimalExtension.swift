//
//  DecimalExtension.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 03/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
