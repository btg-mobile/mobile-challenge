//
//  ConversionViewModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import Foundation

protocol ConversionViewModelDelegate {
    func didConvertValue(value: String)
    func didErrorOcurred(error: String)
}

class ConversionViewModel {
    
    var delegate: ConversionViewModelDelegate?
    
    var value: Double? {
        didSet {
            self.convert()
        }
    }
    
    private var coinOrigin: CoinViewModel? {
        didSet {
            self.convert()
        }
    }
    
    private var coinDestiny: CoinViewModel? {
        didSet {
            self.convert()
        }
    }
    
    var currentQuote: CurrentQuoteResponseModel = CurrentQuoteResponseModel()
    
    init() {
        self.getQuote()
    }
    
    func getQuote() {
        
        CurrencyService.shared.getQuote { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                if model.success ?? false {
                    self.currentQuote = model
                } else {
                    self.delegate?.didErrorOcurred(error: CoinError.invallidData.rawValue)
                }
            case .failure(let error):
                self.delegate?.didErrorOcurred(error: error.rawValue)
            }
        }
        
    }
    
    func setValue(value: Double) {
        self.value = value
    }
    
    func setOriginCoin(model: CoinViewModel) {
        self.coinOrigin = model
    }
    
    func setDestinyCoin(model: CoinViewModel) {
        self.coinDestiny = model
    }
    
    func convert() {
        
        if let value = self.value, let coinOrigin = self.coinOrigin, let coinDestiny = self.coinDestiny {
            if coinOrigin.initials.elementsEqual(coinDestiny.initials) {
                formatConvertedValue(value: value)
            } else if coinOrigin.initials.contains("USD") {
                guard let destinyQuote = currentQuote.quotes?["USD" + coinDestiny.initials] else { return }
                let value = value * destinyQuote
                formatConvertedValue(value: value)
            } else if coinDestiny.initials.contains("USD") {
                guard let originQuote = currentQuote.quotes?["USD" + coinOrigin.initials] else { return }
                let value = value / originQuote
                formatConvertedValue(value: value)
            } else {
                guard let originQuote = currentQuote.quotes?["USD" + coinOrigin.initials] else { return }
                guard let destinyQuote = currentQuote.quotes?["USD" + coinDestiny.initials] else { return }
                
                let value = (value * destinyQuote ) / originQuote
                formatConvertedValue(value: value)
            }
        }
    }
    
    func formatConvertedValue(value: Double) {
        var result = String(format: " %.2f", value)
        result.insert(contentsOf: self.coinDestiny?.initials ?? "", at: result.startIndex)
        delegate?.didConvertValue(value: value == 0 ? "": result)
    }
}
