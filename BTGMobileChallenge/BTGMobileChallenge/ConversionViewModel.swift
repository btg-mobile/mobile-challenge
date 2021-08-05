//
//  ConversionViewModel.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import Foundation

class ConversionViewModel {
	private let repository = ApiRequest()
	
	func getQuotationValue(from: String, to: String ,completion: @escaping (Result<CurrentQuotes, ApiRequestError>) -> Void) {
		repository.getCurrentQuotes { response in
			completion(response)
		}
	}
	
	func getCurrenciesAvaliable(completion: @escaping (Result<AvaliableCurrencies, ApiRequestError>) -> Void) {
		repository.getAvaliableCurrencies { response in
			completion(response)
		}
	}
}
