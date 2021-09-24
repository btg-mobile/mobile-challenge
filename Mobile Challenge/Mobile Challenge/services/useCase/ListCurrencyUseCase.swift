//
//  ListCurrencyUseCase.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

struct ListCurrencyUseCase {
    
    // MARK: - Private properties
    
    private var currencyRepository: CurrencyRepositoryProtocol
    
    // MARK: - Initializer
    
    init(currencyRepository: CurrencyRepositoryProtocol) {
        self.currencyRepository = currencyRepository
    }
    
    // MARK: - Public methods
    
    func listCurrencies(completion: @escaping (Currencies?, Error?) -> Void) {
        currencyRepository.getCurrencyList { result in
            switch result {
            case .success(let currenciesDTO):
                completion(Currencies(list: currenciesDTO.currencies), nil)
                
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
}

