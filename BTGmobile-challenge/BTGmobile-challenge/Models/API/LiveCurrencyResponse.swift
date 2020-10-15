//
//  LiveCurrencyResponse.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 13/10/20.
//

import Foundation

struct LiveCurrencyResponse: Decodable {
	var quotes: [String : Double] = [:]
}
