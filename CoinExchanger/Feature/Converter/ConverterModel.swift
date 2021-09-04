//
//  ConverterModel.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class ConverterModel: UIControl {
    var origin = Storage.retrieve(Constants.originFile, from: .caches, as: Coin.self)
        ?? Coin("xxx", L10n.Coin.Converter.originCoin, 1.0) {
        didSet { Storage.store(origin, to: .caches, as: Constants.originFile) } }
    
    var target = Storage.retrieve(Constants.originFile, from: .caches, as: Coin.self)
        ?? Coin("yyy", L10n.Coin.Converter.targetCoin, 0.9) {
        didSet { Storage.store(origin, to: .caches, as: Constants.originFile) } }
        
    var quotes = Storage.retrieve(Constants.quoteFile, from: .caches, as: GetExchangeList.self)
        ?? GetExchangeList([], true)
    
    var fetchCompletion: () -> Void = {}
    
    func fetchCoins() {
        Repository.getCoins(completion: fetchCoinsCompletion)
    }
    
    func fetchQuotes() {
        Repository.getQuotes(completion: fetchQuotesCompletion)
    }
    
    func appraise() {
        
    }
}

private extension ConverterModel {
    func fetchCoinsCompletion(_ response: GetCoinList?, _ error: Error?) {
        if (response?.success ?? false || DEBUG) {
            let items = response?.items ?? []
            Storage.store(items, to: .caches, as: Constants.coinFile)
            origin = items.isEmpty ? origin : items[0]
            target = items.count > 1 ? items[1] : target
        } else {
            Toast.show(message: L10n.System.Error.connection)
        }
        
        //fetchCompletion()
    }
    
    func fetchQuotesCompletion(_ response: GetExchangeList?, _ error: Error?) {
        if (response?.success ?? false || DEBUG) {
            quotes = response ?? quotes
            Storage.store(quotes, to: .caches, as: Constants.quoteFile)
        } else {
            Toast.show(message: L10n.System.Error.connection)
        }
        
        fetchCompletion()
    }
}
