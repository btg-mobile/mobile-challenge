//
//  Double+Extension.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 01/05/21.
//

import Foundation

extension Double {
    var toDoubleForced: String? {
        return String(format: "%.02f", self)
    }
}
