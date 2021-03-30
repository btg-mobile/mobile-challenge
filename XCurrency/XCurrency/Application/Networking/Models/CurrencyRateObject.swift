//
//  CurrencyRateObject.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 29/03/21.
//

struct CurrencyRateObject: Codable {

    // MARK: - Attributes
    let currenciesRate: [CurrencyRate]
    let success: Bool

    // MARK: - Keys Enum
    enum Keys: String, CodingKey {
        case quotes, source, success
    }

    // MARK: - Initializer
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        self.success = try container.decode(Bool.self, forKey: .success)
        let currenciesDictionary: [String: Double] = try container.decode([String: Double].self, forKey: .quotes)
        self.currenciesRate = currenciesDictionary.map { currencieRate in
            CurrencyRate(source: currencieRate.key, value: currencieRate.value)
        }
    }
}
