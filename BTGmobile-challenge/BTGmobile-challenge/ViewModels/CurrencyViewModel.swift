//
//  CurrencyViewModel.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 07/10/20.
//

import Foundation

final class CurrencyViewModel{
	
	var buttonType: String
	
	let network = NetworkManager()
	
	var listedCurrencies: [ListedCurrency] = []
	
	init(buttonType: String) {
		self.buttonType = buttonType
		listRequest(url: APIUrl.list.rawValue)
	}
	
	func setupCellCode(index: Int) -> String{
		return listedCurrencies[index].initials
	}
		
	func setupCellName(index: Int) -> String {
		return listedCurrencies[index].name

	}
	
	func numberOfRows() -> Int {
		return listedCurrencies.count
	}
	
	func updateCurrency(index: Int) {
		switch self.buttonType {
			case "FROM":
				CurrencyManager.updateFrom(currency: listedCurrencies[index].initials)
			case "TO":
				CurrencyManager.updateTo(currency: listedCurrencies[index].initials)
			default:
				print(Errors.userDefaults.localizedDescription)
		}
	}
	
	func listRequest(url: String) {
		network.request(type: ListedCurrencyResponse(), url: url, completion: ({(response) in
			switch response {
				case .success(let result):
					self.addListedCurrencies(data: result.currencies)
					NotificationCenter.default.post(name: .updateList, object: nil)
					return
				case .failure( _):
					self.addListedCurrencies(data: CurrencyManager.getList())
			}
		}))
	}
	
	func addListedCurrencies(data: [String:String]) {
		listedCurrencies = data.map {ListedCurrency(initials: $0.key, name: $0.value)}
		self.listedCurrencies = listedCurrencies.sorted(by:{ $0.initials < $1.initials })
		NotificationCenter.default.post(name: .updateList, object: nil)
	}

	func updateList() {
		CurrencyManager.updateList(values: self.listedCurrencies)
	}
}

