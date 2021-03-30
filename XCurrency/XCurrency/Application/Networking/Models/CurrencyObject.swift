//
//  CurrencyObject.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

struct CurrencyObject: Codable {
    
    // MARK: - Attributes
    let currencies: [Currency]
    let success: Bool
    
    // MARK: - Keys Enum
    enum Keys: String, CodingKey {
        case currencies, success
    }
    
    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        let currenciesDictionary: [String: String] = try container.decode([String: String].self, forKey: .currencies)
        self.currencies = currenciesDictionary.map { currency in
            Currency(name: currency.value, code: currency.key)
        }
    }
}