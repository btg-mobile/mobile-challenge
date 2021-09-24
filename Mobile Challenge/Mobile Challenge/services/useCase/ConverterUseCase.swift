//
//  ConverterUseCase.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import Foundation

struct ConverterUseCase {
    
    // MARK: - Private properties
    
    private var currencyRepository: CurrencyRepositoryProtocol
    
    // MARK: - Initializer
    
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.currencyRepository = currencyRepository
    }
    
    // MARK: - Public methods
    
    func convertCurrency(from sourceCurrency: String, to targetCurrency: String, completion: @escaping (Double?, Error?) -> Void) {
        currencyRepository.getCurrentDollarQuote { result in
            switch result {
            case .success(let currentDollarQuoteDTO):
                guard let quote = currentDollarQuoteDTO.quotes["\(currentDollarQuoteDTO.source)\(targetCurrency)"] else {
                    completion(0.0, nil)
                    return
                }
                completion(quote, nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

}
