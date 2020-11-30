//
//  Currency.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

struct List: Codable {
    let code: String
    let name: String
    var favorite: Bool = false
    
    /// Salva a opção selecionada na lista de favoritos no `CommonData`
    func saveFavorite() {
        DispatchQueue.main.async {
            if favorite {
                CommonData.shared.favorites.append(self.code)
            } else {
                if let index = CommonData.shared.favorites.firstIndex(where: {$0 == code}) {
                    CommonData.shared.favorites.removeFirst(index)
                }
            }
        }
    }
}

typealias Lists = [List]

extension Lists {
    /// Exemplo de `Lists` de apoio ao desenvolvimento
    static let sample = [
        List(code: "USD", name: "US Dollar"),
        List(code: "CHF", name: "Swiss Franc"),
        List(code: "JPY", name: "Japanese Yen"),
        List(code: "GBP", name: "British Pound")
    ]
    
    /// Salva as `Lists` no `CommonData`.
    /// - Parameter quotes: Um dicionário de `String` e `String` com as informações da `API`.
    static func save(currencies: [String: String]) {
        CommonData.shared.lists = []
        currencies.forEach {
            let list = List(code: $0.key, name: $0.value)
            CommonData.shared.lists.append(list)
        }
    }
    
    /// Encontra um `Currency` por seu código.
    /// - Parameter code: código único de cada moeda.
    /// - Returns `Currency?`: se encontrar algum elemento com o código correspondente retorna o elemento caso contrário, retorna `nil`.
    func finOne(by code: String) -> List? {
        return self.first { $0.code == code }
    }
}
