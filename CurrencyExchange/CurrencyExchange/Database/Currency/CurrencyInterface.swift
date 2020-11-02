//
//  CurrencyDatabaseInterface.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import CoreData

protocol CurrencyInterface {
    
    var coreDataStack: CoreDataStack { get set }
    
    func fetchWithPredicate(_ predicate: NSPredicate?, with sortDescriptors: [NSSortDescriptor]?, completion: @escaping ([Currency]) -> Void) throws
    
    func createWithCurrency(_ currency: Currency)
    
    func deleteAll(completion: @escaping () -> Void) throws
}
