//
//  Database.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit
import CoreData

final class Database {

    static var currentContext: NSManagedObjectContext?

    static var context: NSManagedObjectContext {
        if let currentContext = self.currentContext {
            return currentContext
        }
        
        if Thread.isMainThread {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        } else {
            return DispatchQueue.main.sync {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                return appDelegate.persistentContainer.viewContext
            }
        }
    }

}
