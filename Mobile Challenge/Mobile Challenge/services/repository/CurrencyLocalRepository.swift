//
//  CurrencyLocalRepository.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 24/09/21.
//

import Foundation

struct CurrencyLocalRepository: CurrencyRepositoryProtocol {
    
    // MARK: - Public properties
    
    let userDefault = UserDefaults.standard
    
    // MARK: - Private properties
    
    private enum PersistKey : String {
        case currenciesDTOKey = "com.simoes.daive.Mobile-Challenge.currenciesDTO"
        case dollarQuoteDTOKey = "com.simoes.daive.Mobile-Challenge.currentDollarQuoteDTO"
    }
    
    // MARK: - Public methods
    
    func getCurrencyList(completion: @escaping (Result<CurrenciesDTO, Error>) -> Void) {
        guard let dto = retrieveCurrencyListDTO() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }
        
        return completion(.success(dto))
    }
    
    func getCurrentDollarQuote(completion: @escaping (Result<CurrentDollarQuoteDTO, Error>) -> Void) {
        guard let dto = retrieveCurrentDollarQuoteDTO() else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
            return
        }
        
        return completion(.success(dto))
    }
    
    func saveCurrencyList(currenciesDTO: CurrenciesDTO) {
        userDefault.set(currenciesDTO, forKey: PersistKey.currenciesDTOKey.rawValue)
    }
    
    func saveCurrentDollarQuote(currentDollarQuoteDTO: CurrentDollarQuoteDTO) {
        userDefault.set(currentDollarQuoteDTO, forKey: PersistKey.dollarQuoteDTOKey.rawValue)
    }
    
    // MARK: - Private methods
    
    private func retrieveCurrencyListDTO() -> CurrenciesDTO? {
        guard let dto = userDefault.object(forKey: PersistKey.currenciesDTOKey.rawValue) else {
            return nil
        }
        
        return dto as? CurrenciesDTO
    }
    
    private func retrieveCurrentDollarQuoteDTO() -> CurrentDollarQuoteDTO? {
        guard let dto = userDefault.object(forKey: PersistKey.dollarQuoteDTOKey.rawValue) else {
            return nil
        }
        
        return dto as? CurrentDollarQuoteDTO
    }
    
}
