//
//  Double+DecimalLimit.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 18/12/20.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
