//
//  TaxModel.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import RealmSwift

class TaxModel: Object {

    @objc dynamic var fromCode: String = ""
    @objc dynamic var toCode: String = ""
    @objc dynamic var value: Double = 0

}

extension TaxModel {

    static func createOrUpdate(fromCode: String, toCode: String, value: Double) {
        if let taxModel = TaxModel.get(byFromCode: fromCode, andToCode: toCode) {
            taxModel.update(value: value)
        } else {
            TaxModel.create(fromCode: fromCode, toCode: toCode, value: value)
        }
    }

    static func create(fromCode: String, toCode: String, value: Double) {
        let taxModel = TaxModel()
        taxModel.fromCode = fromCode
        taxModel.toCode = toCode
        taxModel.value = value

        let realm = try! Realm()
        try! realm.write {
            realm.add(taxModel)
        }
    }

    func update(value: Double) {
        let realm = try! Realm()
        try! realm.write {
            self.value = value
        }
    }

    static func get(byFromCode fromCode: String, andToCode toCode: String) -> TaxModel? {
        return try! Realm()
            .objects(TaxModel.self)
            .filter("fromCode == '\(fromCode)' AND toCode == '\(toCode)'")
            .first
    }

    static func getAll() -> [TaxModel] {
        return try! Realm().objects(TaxModel.self).compactMap { $0 }
    }

}
