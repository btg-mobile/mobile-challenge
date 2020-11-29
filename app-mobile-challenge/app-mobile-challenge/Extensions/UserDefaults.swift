//
//  UserDefaults.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import Foundation

extension UserDefaults: UserDefaultsService {
    /// Salva objetos `Codable` no UserDefaults.
    /// - Parameters:
    ///   - encodable: Objeto à ser salvo.
    ///   - key: Chave de gravação do objeto.
    func set<T: Encodable>(encodable: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    /// Realiza a leitura de arquivos `Codable` no UserDefaults.
    /// - Parameters:
    ///   - type: Tipo do objeto à ser carregado.
    ///   - key: Chave do objeto que foi salvo.
    /// - Returns: Se o objeto existir, retorna ele, caso contrário, retorna `nil`.
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
            let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}

