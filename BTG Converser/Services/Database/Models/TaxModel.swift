//
//  TaxModel.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation
import CoreData

final class TaxModel {

    static private let entityName = "Tax"

    static func createOrUpdate(fromCode: String, toCode: String, value: Double) -> Bool {
        if let currency = self.get(byFromCode: fromCode, andToCode: toCode) {
            currency.setValue(value, forKey: "value")
            return true
        }

        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: Database.context)
        let newTax = NSManagedObject(entity: entity!, insertInto: Database.context)

        newTax.setValue(fromCode, forKey: "from_code")
        newTax.setValue(toCode, forKey: "to_code")
        newTax.setValue(value, forKey: "value")

        do {
            try Database.context.save()
            return true
        } catch {
            print("Error on save Tax")
            return false
        }
    }

    static func get(byFromCode fromCode: String, andToCode toCode: String) -> Tax? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName)
        request.predicate = NSPredicate(format: "from_code == %@ AND to_code == %@", fromCode, toCode)
        request.returnsObjectsAsFaults = false
        do {
            let result = try Database.context.fetch(request) as? [Tax]
            return result?.first
        } catch {
            return nil
        }
    }

}
