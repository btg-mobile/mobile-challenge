//
//  Debugger.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import Foundation

final class Debugger {
    static func log(_ items: Any...) {
        #if DEBUG
        print(items)
        #endif
    }
}
