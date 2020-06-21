//
//  CurrencyLayerRepository.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

enum CurrencyLayerServiceErrors: String {
    case parseToModel = "Couldn't parse response to model."
    case emptyQuotes = "No quotes available"
    case emptyCurrencies = "No currencies available"
}

class CurrencyLayerRepository {
    
    var session = URLSession.shared
    var currenciesList: CurrenciesList?   //  cache, save this !!
    
    // MARK: Shared
    class func sharedInstance() -> CurrencyLayerRepository {
        struct Singleton {
            static var sharedInstance = CurrencyLayerRepository()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: Helpers
    func createError(_ error: CurrencyLayerServiceErrors) -> NSError {
        return NSError(domain: "convertData", code: 1, userInfo: [NSLocalizedDescriptionKey: [NSLocalizedDescriptionKey : error.rawValue]])
    }
    
    // MARK: API calls
    func getCurrenciesList(_ completionHandler: @escaping (_ response: CurrenciesList?, _ error: NSError?) -> Void) {
        if let currencies = currenciesList {
            completionHandler(currencies, nil)
        } else {
            let request = CurrenciesListRequest()
            BaseRequester().taskForGETMethod(request: request, responseType: CurrenciesListResponse.self) { (response, error) in
                if let response = response {
                    let currenciesList = CurrenciesList(with: response)
                    guard currenciesList.currencies.count > 0 else {
                        completionHandler(nil, self.createError(.emptyCurrencies))
                        return
                    }
                    self.currenciesList = currenciesList
                    completionHandler(currenciesList, nil)
                } else {
                    completionHandler(nil, error)
                }
            }
        }
    }
    
    func getLiveQuotes(_ completionHandler: @escaping (_ response: QuotesList?, _ error: NSError?) -> Void) {
        let request = LiveQuotesRequest()
        BaseRequester().taskForGETMethod(request: request, responseType: LiveQuotesResponse.self) { (response, error) in
            if let response = response {
                guard let currencies = self.currenciesList else {
                    completionHandler(nil, self.createError(.parseToModel))
                    return
                }
                let quotesList = QuotesList(with: response, availableCurrenciesList: currencies)
                guard quotesList.quotes.count > 0 else {
                    completionHandler(nil, self.createError(.emptyQuotes))
                    return
                }
                completionHandler(quotesList, nil)
            } else {
                completionHandler(nil, error)
            }
        }
    }
    
}


