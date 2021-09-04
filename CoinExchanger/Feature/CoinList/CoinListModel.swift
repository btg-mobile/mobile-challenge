//
//  CoinListModel.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class CoinListModel: UIControl {
    var data: [Coin] = Storage.retrieve(Constants.coinFile, from: .caches, as: [Coin].self) ?? []
    var items: [Coin] = []
    var ord = 0 { didSet { ordenateItems() } } // 0 = name, 1 = id
    var search: String = "" { didSet { startTimer() } }
    var timer: Timer?
    
    var fetchCompletion: () -> Void = {}
    var reloadData: () -> Void = {}
    
    func fetchData() { Repository.getCoins(completion: fetchDataCompletion) }
}

private extension CoinListModel {
    func fetchDataCompletion(_ response: GetCoinList?, _ error: Error?) {
        if (response?.success ?? false || DEBUG) {
            items = response?.items ?? items
            Storage.store(items, to: .caches, as: Constants.coinFile)
        } else {
            Toast.show(message: L10n.System.Error.connection)
        }
        
        fetchCompletion()
    }
    
    func filter(by text: String?) {
        var n: [Coin] = []
        let t = Sanityze.normalize(text)
        
        items = data
        
        if !t.isEmpty {
            for item in items {
                let a = Sanityze.normalize(item.name)
                let q = Sanityze.normalize(item.cod)
                if (a.contains(t)) || q.contains(t) { n.append(item) }
            }
            
            items = n
        }
        
        ordenateItems()
        
        reloadData()
    }
    
    func setItems() {
        items = data
        ordenateItems()
    }
    
    func ordenateItems() {
        switch ord {
        case 0:
            items.sort(by: { $0.name ?? "" < $1.name ?? "" })
        case 1:
            items.sort(by: { $0.cod ?? "" < $1.cod ?? "" })
        default:
            break
        }
    }
    
    func startTimer() {
        endTimer()
        timer = Timer.scheduledTimer(timeInterval: Constants.searchDelay,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    func endTimer() {
        timer?.invalidate()
    }
    
    @objc
    func timerAction() {
        filter(by: search)
    }
}
