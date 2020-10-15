//
//  Enumeration.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 07/10/20.
//

import Foundation
import UIKit

enum Errors: Error {
	case userDefaults
}


enum APIUrl: String {
	case list = "http://api.currencylayer.com/list?access_key=2de098ddfc19bb9132733458f4eb055e"
	
	case live = "http://apilayer.net/api/live?access_key=2de098ddfc19bb9132733458f4eb055e&format=1"
}


enum CurrencyKey: String {
	case list = "list"
	
	case live = "live"
	
	case values = "values"
}
