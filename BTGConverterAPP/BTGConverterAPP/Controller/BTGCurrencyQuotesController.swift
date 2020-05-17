//
//  BTGCurrencyQuotesController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

class BTGCurrencyQuotesController {
    
    private let networkController = BTGNetworkController.shared
    private var quotes : [String: Double]? {
        didSet {
            error = ""
        }
    }
    private var error : String = ""
    private var lastTimeUpdated = ""
    
    func getQuotes() -> [String: Double]? {
        return quotes
    }
    
    func getLastError()-> String {
        return error
    }
    
    func getLastTimeUpdatedFormatted() -> String {
        return lastTimeUpdated
    }
    
    func loadQuotes() {
                networkController.getLiveCurrencies { [weak self] in
                    switch $0 {
                    case .success(let result):
                        self?.quotes = result.quotes
                        let newDate = result.timestamp
                        let components =  newDate.addingTimeInterval(result.timestamp.distance(to: Date())).addingTimeInterval(TimeInterval(integerLiteral: -3600*3)).description.components(separatedBy: " ")
                        self?.lastTimeUpdated = "\(components[0]) \(components[1])"
                    case .failure(let resultError):
                        self?.error = resultError.rawValue
                    }
                }
    }
    
}

extension Date {
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
