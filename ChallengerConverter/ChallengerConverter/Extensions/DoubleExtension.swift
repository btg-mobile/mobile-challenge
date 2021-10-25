//
//  DoubleExtension.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 25/10/21.
//

import Foundation


extension Double {
    
    func toCyrrency()-> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self))!
    }
    
}
