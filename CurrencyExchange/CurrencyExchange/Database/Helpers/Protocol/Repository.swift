//
//  Repository.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import CoreData

protocol Repository {
    
    associatedtype Entity
    
    func getWithPredicate(_ predicate: NSPredicate?, withSortDescriptors sortDescriptors: [NSSortDescriptor]?, completion: @escaping ([Entity]) -> Void) throws
    
    func create(completion: @escaping (Entity) -> Void) throws
    
    func deleteWithEntity(_ entity: Entity, completion: @escaping (Bool) -> Void) throws
}

