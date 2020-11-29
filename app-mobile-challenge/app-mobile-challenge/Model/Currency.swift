//
//  Currency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

struct Currency {
    let code: String
    let name: String
    var favorite: Bool = false
    
    func save() {
        if favorite {
            CommonData.shared.favorites.append(self.code)
        } else {
            if let index = CommonData.shared.favorites.firstIndex(where: {$0 == code}) {
                CommonData.shared.favorites.remove(at: index)
            }
            
        }
        
    }
}

typealias Currencies = [Currency]

extension Currencies {
    static let sample = [
        Currency(code: "USD", name: "US Dollar"),
        Currency(code: "CHF", name: "Swiss Franc"),
        Currency(code: "JPY", name: "Japanese Yen"),
        Currency(code: "GBP", name: "British Pound")
    ]
    
    /// Encontra um `Currency` por seu código.
    /// - Parameter code: código único de cada moeda.
    /// - Returns `Currency?`: se encontrar algum elemento com o código correspondente retorna o elemento caso contrário, retorna `nil`.
    func finOne(by code: String) -> Currency? {
        return self.first { $0.code == code }
    }
}
