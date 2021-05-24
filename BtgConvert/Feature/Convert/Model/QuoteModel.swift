//
//  QuoteModel.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation

struct QuoteModel {
    let ref: String
    let value: Double
    init(ref: String, value: Double) {
        self.ref = ref
        self.value = value
    }
}
