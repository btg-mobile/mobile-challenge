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

    static var context: NSManagedObjectContext {
        DispatchQueue.main.sync {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }
    }

}
