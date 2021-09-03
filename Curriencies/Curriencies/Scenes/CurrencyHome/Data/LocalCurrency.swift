//
//  LocalCurrency.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

import CoreData
import UIKit

protocol LocalCurrencyProtocol {
    func getCurrency(completion: (Result<[CurrencyEntity], RepositoryError>) -> Void)
    func updateCurrency(currencies: [CurrencyEntity])
}

struct LocalDataCurrency {
    let context: NSManagedObjectContext?
    
    init() {
        let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        context = appDelegate?.persistentContainer.viewContext
    }
}

extension LocalDataCurrency: LocalCurrencyProtocol {
    func getCurrency(completion: (Result<[CurrencyEntity], RepositoryError>) -> Void) {
        getCurrency { (result: Result<[LocalCurrency], RepositoryError>) in
            switch result {
            case let .success(localEntities):
                let entities = localEntities.map {
                    CurrencyEntity(code: $0.code ?? "BRL",
                                   name: $0.name ?? "Brazilian Real",
                                   value: $0.value)
                }
                completion(.success(entities))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func updateCurrency(currencies: [CurrencyEntity]) {
        getCurrency { (result: Result<[LocalCurrency], RepositoryError>) in
            switch result {
            case let .success(localCurrencies):
                if !localCurrencies.isEmpty {
                    deleteAllCurrencies(currencies: localCurrencies)
                }
                saveCurrency(currencies: currencies)
            case .failure(_):
                break
            }
        }
    }
}

private extension LocalDataCurrency {
    func deleteAllCurrencies(currencies: [LocalCurrency]) {
        guard let context = context else { return }
        
        for currency in currencies {
            context.delete(currency)
        }
        
        try? context.save()
    }
    
    func saveCurrency(currencies: [CurrencyEntity]) {
        guard let context = context else { return }
        
        for currency in currencies {
            let entity = LocalCurrency(context: context)
            entity.code = currency.code
            entity.name = currency.name
            entity.value = currency.value
        }
        
        try? context.save()
    }
    
    func getCurrency(completion: (Result<[LocalCurrency], RepositoryError>) -> Void) {
        guard let context = context else {
            completion(.failure(.generic))
            return
        }
        
        do {
            var localEntities: [LocalCurrency] = []
            localEntities = try context.fetch(LocalCurrency.fetchRequest())
            completion(.success(localEntities))
        } catch {
            completion(.failure(.generic))
        }
    }
}
