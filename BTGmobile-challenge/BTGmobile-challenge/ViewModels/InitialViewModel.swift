//
//  InitialViewModel.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 09/10/20.
//

import Foundation
protocol InitialViewModelDelegate: AnyObject {
	func updateInput(result: String)
	func updateResult(result: String)
}

final class InitialViewModel {
	
	let coordinator: CurrencyCoordinator
	
	let network = NetworkManager()
	
	var liveCurrencies: [LiveCurrency] = []
	
	var initialAmount: String = ""
	
	weak var delegate: InitialViewModelDelegate?
	
	
	init(coordinator: CurrencyCoordinator) {
		self.coordinator = coordinator
	}
	
	func presentCurrencyViewController(buttonType: String) {
		coordinator.presentCurrencyViewController(buttonType: buttonType)
	}
	
	internal func getFrom() -> String? {
		CurrencyManager.getValues().first?.uppercased()
	}
	
	internal func getTo() -> String? {
		CurrencyManager.getValues().last?.uppercased()
	}
	
	internal func liveRequest(url: String){
		network.request(type: LiveCurrencyResponse(), url: url, completion: ({(response) in
			switch response {
				case .success(let result):
					self.addLiveCurrencies(data: result.quotes)
					NotificationCenter.default.post(name: .updateLive, object: nil)
					return
				case .failure( _):
					self.addLiveCurrencies(data: CurrencyManager.getLive())
			}
		}))
	}
	
	private func addLiveCurrencies(data: [String:Double]) {
		self.liveCurrencies = data.map {LiveCurrency(initials: $0.key, value: $0.value)}
		NotificationCenter.default.post(name: .updateLive, object: nil)
	}
	
	internal func updateLive() {
		CurrencyManager.updateLive(values: self.liveCurrencies)
	}
	
	internal func makeRequest(fromTitle: String,toTitle: String ) {
		if (fromTitle != "FROM" && toTitle != "TO") {
			liveRequest(url: APIUrl.live.rawValue )
		}
	}
	
	internal func converteFromDolar(currencies: [LiveCurrency], currency: String) -> Double {
		for amount in currencies {
			if amount.initials == "USD"+currency {
				return amount.value
			}
		}
		return 0
	}
	
	internal func converte(firstCurrency: Double, secondCurrency:Double, amount: Double ) -> Double {
		return (amount * secondCurrency)/firstCurrency
	}
	
	internal func conversionTo() {
		let firstCurrency: Double = converteFromDolar(currencies: self.liveCurrencies, currency: getFrom() ?? "FROM")
		let secondCurrency: Double = converteFromDolar(currencies: self.liveCurrencies, currency: getTo() ?? "TO")
		let amount: Double = (initialAmount.replacingOccurrences(of: ",", with: ".") as NSString).doubleValue
		let conversionResult = converte(firstCurrency: firstCurrency, secondCurrency: secondCurrency, amount: amount)
		delegate?.updateResult(result: validateResult(result: conversionResult))
	}
	
	internal func validateResult(result: Double) -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencySymbol = ""
		formatter.currencyGroupingSeparator = ","
		formatter.currencyDecimalSeparator = "."
		
		if (formatter.string(from: NSNumber(value: result))) == "NaN" {
			return ""
		}
		
		return ((getTo() ?? "") + " " +  (formatter.string(from: NSNumber(value: result)) ?? ""))
	}
	
}

