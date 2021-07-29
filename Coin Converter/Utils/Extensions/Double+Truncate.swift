//
//  Double+Truncate.swift
//  Coin Converter
//
//  Created by Igor Custodio on 29/07/21.
//

import Foundation

extension Double {
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}
