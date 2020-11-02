//
//  CurrencyDAO.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 01/11/20.
//

import CoreData

class CurrencyDAO: CurrencyInterface {
    
    var coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack){
        self.coreDataStack = coreDataStack
    }
    
    func fetchWithPredicate(_ predicate: NSPredicate?, with sortDescriptors: [NSSortDescriptor]?, completion: @escaping ([Currency]) -> Void) throws {

        let fetchRequest = NSFetchRequest<CurrencyCD>(entityName: CurrencyCD.uniqueIdentifier)
        
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let currenciesCD = try coreDataStack.viewContext.fetch(fetchRequest)
        
            var currencies: [Currency] = []
            currencies = currenciesCD.map {
                $0.toDomainModel()
            }
            
            completion(currencies)
        }catch {
            throw CoreDataError.cannotBeFetched
        }
    }
    
    func createWithCurrency(_ currency: Currency) {
        let currencyCD = CurrencyCD(context: self.coreDataStack.viewContext)
        currencyCD.name = currency.name
        currencyCD.code = currency.code
        currencyCD.value = currency.value
        
        self.coreDataStack.saveContext()
    }
    
    func deleteAll(completion: @escaping () -> Void) throws {
        let fetchRequest = NSFetchRequest<CurrencyCD>(entityName: CurrencyCD.uniqueIdentifier)
                
        do {
            let currenciesCD = try coreDataStack.viewContext.fetch(fetchRequest)
        
            for currencyCD in currenciesCD {
                self.coreDataStack.viewContext.delete(currencyCD)
            }
            
            completion()
        }catch {
            throw CoreDataError.cannotBeDeleted
        }
    }
    
    
}
