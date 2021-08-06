//
//  ConversionViewModel.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import Foundation

class ConversionViewModel {
	private let repository = ApiRequest()
	
	func getQuotationValue(from: String, to: String, quantity: Float, completion: @escaping (Result<Float, ApiRequestError>) -> Void) {
		repository.getCurrentQuotes { response in
			switch response {
			case .success(let currentQuotes):
				guard let fromCurrency = currentQuotes.quotes[from], let toCurrency = currentQuotes.quotes[to] else { return completion(.failure(.quoteNotFound)) }
				completion(.success(quantity * (fromCurrency - toCurrency)))
			
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
	
	func getCurrenciesAvaliable(completion: @escaping (Result<[String: Any], ApiRequestError>) -> Void) {
		repository.getAvaliableCurrencies { response in
			switch response {
			case .success(let avaliableCurrencies):
				completion(.success(avaliableCurrencies.currencies))
				
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
