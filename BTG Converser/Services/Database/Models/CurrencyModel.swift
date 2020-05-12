//
//  CurrencyModel.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import RealmSwift

class CurrencyModel: Object  {

    @objc dynamic var code: String = ""
    @objc dynamic var name: String = ""

}

extension CurrencyModel {

    static func createOrUpdate(code: String, name: String) {
        if CurrencyModel.get(byCode: code) != nil {
            CurrencyModel.update(code: code, name: name)
        } else {
            return CurrencyModel.create(code: code, name: name)
        }
    }

    static func create(code: String, name: String) {
        let currencyModel = CurrencyModel()
        currencyModel.code = code
        currencyModel.name = name

        let realm = try! Realm()
        try! realm.write {
            realm.add(currencyModel)
        }
    }

    static func update(code: String, name: String) {
        let realm = try! Realm()

        let currency = realm.objects(CurrencyModel.self)
            .filter("code == '\(code)'")
            .first

        try! realm.write {
            currency?.name = name
        }
    }

    static func get(byCode code: String) -> CurrencyModel? {
        return try! Realm()
            .objects(CurrencyModel.self)
            .filter("code == '\(code)'")
            .first
    }

    static func getAll() -> [CurrencyModel] {
        return try! Realm().objects(CurrencyModel.self).compactMap { $0 }
    }

}
