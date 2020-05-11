//
//  CurrencyConverter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class CurrencyConverter {

    let fromCode: String
    let toCode: String

    private let defaultCurrencyCode = "USD"

    init(fromCode: String, toCode: String) {
        self.fromCode = fromCode
        self.toCode = toCode
    }

    func convertValue(_ value: Double) -> Double? {
        if fromCode == toCode {
            return value
        }

        if let valueConverted = self.convertValueDirectly(value) {
            return valueConverted
        }

        if let valueConverted = self.convertValueDirectlyByInverting(value) {
            return valueConverted
        }

        return self.convertValueUsingDefaultCurrency(value)
    }

    private func convertValueDirectly(_ value: Double) -> Double? {
        if let tax = TaxModel.get(byFromCode: self.fromCode, andToCode: self.toCode) {
            return value * tax.value
        }

        return nil
    }

    private func convertValueDirectlyByInverting(_ value: Double) -> Double? {
        if let tax = TaxModel.get(byFromCode: self.toCode, andToCode: self.fromCode) {
            return value / tax.value
        }

        return nil
    }

    private func convertValueUsingDefaultCurrency(_ value: Double) -> Double? {
        guard let fromTax = TaxModel.get(byFromCode: self.defaultCurrencyCode, andToCode: self.fromCode),
            let toTax = TaxModel.get(byFromCode: self.defaultCurrencyCode, andToCode: self.toCode)
            else { return nil }

        return value / fromTax.value * toTax.value
    }

}
