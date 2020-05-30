//
//  CurrenciesListResponse.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
class CurrenciesListResponse: Codable {
    var success: Bool?
    var terms: String?
    var privacy: String?
    var currencies: Currency?
    var error: CurrencyError?
}
