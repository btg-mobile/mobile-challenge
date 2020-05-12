//
//  UserPreferences.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class LocalData {

    static let instance = LocalData()

    private init() {}

    private let apiLastUpdateDateKey = "apiLastUpdateDateKey"

    var apiLastUpdateDate: Date? {
        get {
            UserDefaults.standard.object(forKey: self.apiLastUpdateDateKey) as? Date
        }

        set(newVal) {
            UserDefaults.standard.set(newVal, forKey: self.apiLastUpdateDateKey)
        }
    }
}
