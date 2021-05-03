//
//  CountryCurrencyModel.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation

struct CountryCurrencyModel {
    let name: String
    let ref: String
    init(name: String, ref: String) {
        self.name = name
        self.ref = ref
    }
    
    func getFormattedName() -> String {
        return name + " - " + ref
    }
    
    var completeRef: String {
        return "USD" + ref
    }
}
