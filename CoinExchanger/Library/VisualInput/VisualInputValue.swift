//
//  VisualInputValue.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class VisualInputValue: VisualInput {
    private var enteredNumbers = ""

    private var didBackspace = false

    var locale: Locale = .current
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    override func deleteBackward() {
        enteredNumbers = String(enteredNumbers.dropLast())
        text = enteredNumbers.asCurrency(locale: locale)
        didBackspace = true
        super.deleteBackward()
    }
}

private extension VisualInputValue {
    func setup() {
        keyboardType = .numberPad
        textAlignment = .right
        
        self.addTarget(self,
                       action: #selector(textFieldDidChange),
                       for: .editingChanged)
    }
    
    @objc
    func textFieldDidChange() {
        defer {
            didBackspace = false
            text = enteredNumbers.asCurrency(locale: locale)
            visualDelegate?.didChange(self)
        }

        guard didBackspace == false else { return }

        if let lastEnteredCharacter = text?.last, lastEnteredCharacter.isNumber {
            enteredNumbers.append(lastEnteredCharacter)
        }
        
    }
}

private extension Formatter {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }()
}

private extension String {
    func asCurrency(locale: Locale) -> String? {
        Formatter.currency.locale = locale
        if self.isEmpty {
            return Formatter.currency.string(from: NSNumber(value: 0))
        } else {
            return Formatter.currency.string(from: NSNumber(value: (Double(self) ?? 0) / 100))
        }
    }
}
