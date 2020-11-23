//
//  NetworkError.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

enum NetworkError: Error {
    case deviceOffline
    case unknownError
    case invalidURL
    case APIError
    case decodeFailure
    
    var errorDescription: String? {
        switch self {
        case .deviceOffline: return "Dispositivo sem conexão."
        case .unknownError: return "Ocorreu um erro."
        case .APIError: return "Erro na requisição."
        case .decodeFailure: return "Erro na intrepretação de dados."
        case .invalidURL: return "URL inválida."
        }
    }
}
