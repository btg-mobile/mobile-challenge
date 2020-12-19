//
//  LocalStorage.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 19/12/20.
//

import Foundation

@propertyWrapper class LocalStorage<T: Codable> {
    private let userDefaults = UserDefaults.standard
    private let key: UserDefaultsKey

    init(key: UserDefaultsKey) {
        self.key = key
    }

    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            userDefaults.set(data, forKey: key)
        }
    }

    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = userDefaults.object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }

    var wrappedValue: T? {
        get {
            return value(T.self, forKey: key.rawValue)
        }
        set {
            set(encodable: newValue, forKey: key.rawValue)
        }
    }
}
