//
//  UserDefaultsAccess.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import Foundation

@propertyWrapper struct UserDefaultAccess<T> {
    let key: String
    let defaultValue: T
    let userDefaults: UserDefaultsService

    init(key: String,
         defaultValue: T,
         userDefaults: UserDefaultsService = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.userDefaults = userDefaults
    }

    var wrappedValue: T {
        get {
            return userDefaults.object(forKey: key) as? T ?? defaultValue
        }
        set {
            userDefaults.setValue(newValue, forKey: key)
        }
    }
}

protocol UserDefaultsService {
    func object(forKey: String) -> Any?
    func setValue(_ value: Any?, forKey key: String)
}

extension UserDefaults: UserDefaultsService {}
