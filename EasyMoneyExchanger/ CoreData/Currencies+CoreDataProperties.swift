//
//  Currencies+CoreDataProperties.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 10/12/20.
//
//

import Foundation
import CoreData

extension Currencies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currencies> {
        return NSFetchRequest<Currencies>(entityName: "Currencies")
    }

    @NSManaged public var currencies: [String: String]?

}

extension Currencies : Identifiable {

}
