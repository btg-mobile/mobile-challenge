//
//  Configured.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

@propertyWrapper
struct Configured<Value> {
    
    private let valueKey: String
    private let storage: UserDefaults = .standard
    private let defaultValue: Value
    
    var wrappedValue: Value {
        set { storage.set(newValue, forKey: valueKey) }
        get { storage.value(forKey: valueKey) as? Value ?? defaultValue  }
    }
    
    init(valueKey: String, defaultValue: Value) {
        self.valueKey = valueKey
        self.defaultValue = defaultValue
    }
}
