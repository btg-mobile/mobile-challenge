//
//  CurrencyManager.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 09/10/20.
//

import Foundation

struct CurrencyManager {
	
	static func start() {
		guard var _ = UserDefaults.standard.object(forKey: CurrencyKey.values.rawValue) as? [String] else {
			let aux: [String] = ["FROM", "TO"]
			UserDefaults.standard.set(aux, forKey: CurrencyKey.values.rawValue)
			return
		}
		
		guard var _ = UserDefaults.standard.object(forKey: CurrencyKey.list.rawValue) as? [String:String] else {
			let aux: [String : String] = [:]
			UserDefaults.standard.set(aux, forKey: CurrencyKey.list.rawValue)
			return
		}
		
		guard var _ = UserDefaults.standard.object(forKey: CurrencyKey.live.rawValue) as? [String: Double] else {
			let aux: [String : Double] = [:]
			UserDefaults.standard.set(aux, forKey: CurrencyKey.live.rawValue)
			return
		}
	}
	
	static func getValues() -> [String] {
		guard let aux = UserDefaults.standard.object(forKey: CurrencyKey.values.rawValue) as? [String] else {
			return ["FROM","TO"]
		}
		return aux
	}
	
	static func updateTo(currency: String) {
		guard var aux = UserDefaults.standard.object(forKey: CurrencyKey.values.rawValue) as? [String] else { return }
		aux[1] = currency
		UserDefaults.standard.set(aux, forKey: CurrencyKey.values.rawValue)
	}
	
	static func updateFrom(currency: String) {
		guard var aux = UserDefaults.standard.object(forKey: CurrencyKey.values.rawValue) as? [String] else { return }
		aux[0] = currency
		UserDefaults.standard.set(aux, forKey: CurrencyKey.values.rawValue)
	}
	
	static func updateList(values: [ListedCurrency]) {
		guard var aux = UserDefaults.standard.object(forKey: CurrencyKey.list.rawValue) as? [String:String] else { return }
		aux = Dictionary(uniqueKeysWithValues: values.map{ ($0.initials, $0.name) })
		UserDefaults.standard.set(aux, forKey: CurrencyKey.list.rawValue)
	}
	
	static func updateLive(values:[LiveCurrency]){
		guard var aux = UserDefaults.standard.object(forKey: CurrencyKey.live.rawValue) as? [String:Double] else { return }
		aux = Dictionary(uniqueKeysWithValues: values.map{ ($0.initials, $0.value) })
		UserDefaults.standard.set(aux, forKey: CurrencyKey.live.rawValue)
	}
	
	static func getList() -> [String: String] {
		guard let aux = UserDefaults.standard.object(forKey: CurrencyKey.list.rawValue) as? [String:String] else {
			NotificationCenter.default.post(name: .emptyData, object: nil)
			return ["":""]
		}
		if (aux.isEmpty) {
			NotificationCenter.default.post(name: .emptyData, object: nil)
		}
		return aux
	}
	
	
	
	static func getLive() -> [String: Double] {
		guard let aux = UserDefaults.standard.object(forKey: CurrencyKey.live.rawValue) as? [String:Double] else {
			return ["":0]
		}
		return aux
	}
}
