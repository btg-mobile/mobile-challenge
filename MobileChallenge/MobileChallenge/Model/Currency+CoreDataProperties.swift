//
//  Currency+CoreDataProperties.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 06/02/25.
//
//

import Foundation
import CoreData


extension Currency {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
        return NSFetchRequest<Currency>(entityName: "Currency")
    }

    @NSManaged public var key: String?
    @NSManaged public var value: String?

}

extension Currency : Identifiable {

}
