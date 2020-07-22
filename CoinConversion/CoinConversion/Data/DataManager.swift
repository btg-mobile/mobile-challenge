//
//  DataManager.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 22/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import CoreData

class DataManager: NSObject {
    
    private var coreDataStack = CoreDataStack.shared
    
    var viewContext: NSManagedObjectContext {
        return coreDataStack.persistentContainer.viewContext
    }
    
    func syncQuotes(with conversionCurrencies: ConversionModel) {
        self.deleteAllData("ConversionEntity")
        self.savingQuotes(with: conversionCurrencies, taskContext: viewContext)
    }
    
    func hasDatabaseQuotes() -> Bool {
        let personRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ConversionEntity")
        do {
            let personResult = try viewContext.fetch(personRequest) as? [ConversionEntity]
            if personResult?.count ?? 0 > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("error \(error), \(error.userInfo)")
            return false
        }
    }
    
    private func savingQuotes(with conversionCurrencies: ConversionModel, taskContext: NSManagedObjectContext) {
        if let quotesEntity = NSEntityDescription.entity(forEntityName: "ConversionEntity", in: taskContext) {
            conversionCurrencies.conversion?.forEach { conversionQuotes in
                let conversion = NSManagedObject(entity: quotesEntity, insertInto: taskContext)
                conversion.setValue(conversionQuotes.code, forKeyPath: "code")
                conversion.setValue(conversionQuotes.quotes, forKey: "quotes")
                conversion.setValue(conversionCurrencies.date, forKey: "timestamp")
            }
            
            do {
                try taskContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func fetchDatabaseQuotes() -> ConversionModel? {
        
        var conversion: [ConversionCurrenciesModel] = []
        let quotesEntity = NSFetchRequest<NSFetchRequestResult>(entityName: "ConversionEntity")
        
        do {
            let quotesData = try viewContext.fetch(quotesEntity) as? [ConversionEntity]
            guard let objectData = quotesData else { return nil }

            for data in objectData {
                conversion.append(
                    ConversionCurrenciesModel(code: data.code ?? "", quotes: data.quotes)
                )
            }
            return ConversionModel(date: objectData.first!.timestamp, conversion: conversion)
        } catch {
            return nil
        }
    }
    
    func deleteAllData(_ entity:String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else { continue }
                viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in \(entity) error :", error)
        }
    }
}

