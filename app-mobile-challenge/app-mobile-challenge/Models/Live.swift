//
//  List.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

struct Live: Codable {
    let code: String
    let quote: Double
}

typealias Lives = [Live]

extension Lives {
    /// Exemplo de `Lives` de apoio ao desenvolvimento
    static let sample = [
        Live(code: "USDAED", quote: 3.673042),
        Live(code: "USDAFN", quote: 77.000368),
        Live(code: "USDALL", quote: 103.650403),
        Live(code: "USDAMD", quote: 508.210403)
    ]
    
    /// Salva as `Lives` no `CommonData`.
    /// - Parameter quotes: Um dicionário de `String` e `Double` com as informações da `API`.
    static func save(quotes: [String: Double]) {
        CommonData.shared.lives = []
        quotes.forEach {
            let live = Live(code: $0.key, quote: $0.value)
            CommonData.shared.lives.append(live)
        }
    }
    
    
    /// Encontra um `Currency` por seu código.
    /// - Parameter code: código único de cada moeda.
    /// - Returns `Currency?`: se encontrar algum elemento com o código correspondente retorna o elemento caso contrário, retorna `nil`.
    func finOne(by code: String) -> Live? {
        return self.first { $0.code == code }
    }
}
