//
//  CoreDataStorage.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation

class CoreDataManager {

    private(set) var connector: CoreDataProtocol

    init(connector: CoreDataProtocol = CoreDataStack.standard) {
        self.connector = connector
    }
    
    
}
