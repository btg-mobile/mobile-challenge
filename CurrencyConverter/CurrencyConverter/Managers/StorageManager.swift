//
//  StorageManager.swift
//  CurrencyConverter
//
//  Created by Tiago Chaves on 09/02/20.
//  Copyright © 2020 Tiago Chaves. All rights reserved.
//

import Foundation

protocol StorageManager {
    func save<T>(data:T)
    func get<T>(data:T) -> T
    func delete<T>(data: T)
    func clear()
}

extension StorageManager {
    func clear() { }
}
