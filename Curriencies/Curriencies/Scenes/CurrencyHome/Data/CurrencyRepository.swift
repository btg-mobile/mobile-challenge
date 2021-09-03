//
//  CurrencyRepository.swift
//  Curriencies
//
//  Created by Ferraz on 03/09/21.
//

struct CurrencyRepository {
    let apiCurrency: APICurrencyProtocol
    let localCurrency: LocalCurrencyProtocol
}

extension CurrencyRepository: CurrencyRepositoryProtocol {
    func getCurrencies(completion: @escaping(Result<[CurrencyEntity], RepositoryError>) -> Void) {
        apiCurrency.getCurrency { result in
            switch result {
            case let .success(entities):
                localCurrency.saveCurrency(currencies: entities)
                completion(.success(entities))
            case .failure(_):
                localCurrency.getCurrency { localResult in
                    completion(localResult)
                }
            }
        }
    }
}
