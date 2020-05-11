//
//  CurrencyModel.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation
import CoreData

final class CurrencyModel {

    static private let entityName = "Currency"

    static func createOrUpdate(code: String, name: String) -> Bool {
        if let currency = self.get(byCode: code) {
            currency.setValue(name, forKey: "name")
            return true
        }

        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: Database.context)
        let newTax = NSManagedObject(entity: entity!, insertInto: Database.context)

        newTax.setValue(code, forKey: "code")
        newTax.setValue(name, forKey: "name")

        do {
            try Database.context.save()
            return true
        } catch {
            print("Error on save Currency")
            return false
        }
    }

    static func get(byCode code: String) -> Currency? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        request.predicate = NSPredicate(format: "code == %@", code)
        request.returnsObjectsAsFaults = false
        do {
            let result = try Database.context.fetch(request) as? [Currency]
            return result?.first
        } catch {
            return nil
        }
    }

}
