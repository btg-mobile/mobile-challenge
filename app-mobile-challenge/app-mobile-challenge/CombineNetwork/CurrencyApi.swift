//
//  NetworkManager.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation
import Combine


/// `Combine` responsável pelas requisições da API.
final class CurrencyApi: CurrencyProvider {
    
    /// Em produção esse valor deve ser omitido.
    private var accessKey: String {
        return "?access_key=7787f5623cd1653ff167db4f9c441026"
    }
    /// Base de URL para a requisição.
    private let baseURL = "http://api.currencylayer.com/"
    
    /// Possíveis rotas de comunicação.
    private enum Endpoint: String {
        case list = "list"
        case live = "live"
    }
    
    /// Métodos possíveis da requisição.
    private enum Method: String {
        case GET
    }
    
    /// Padrão de projetos: Singleton
    private init() {}
    static let shared = CurrencyApi()
    
    
    /// Realiza a requisição para a lista de moedas passivéis de conversão.
    /// - Returns: `Publisher` da request.
    func lists() -> AnyPublisher<ListCurrency, APIError> {
        call(.list, method: .GET)
    }
    /// Realiza a requisição para a lista de moedas com os seus respectivos valores.
    /// - Returns: `Publisher` da request.
    func lives() -> AnyPublisher<LiveCurrency, APIError> {
        call(.live, method: .GET)
    }
    
    /// Rrealiza a request do `Combine`
    /// - Parameters:
    ///   - endPoint: Define a rota ao qual será realizada a request.
    ///   - method: Define o método ao qual a request será feita
    /// - Returns: `Publisher` da request.
    private func call<T: Codable>(_ endPoint: Endpoint, method: Method) -> AnyPublisher<T, APIError> {
            let urlRequest = request(for: endPoint, method: method)
            
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .retry(3)
                .mapError{ _ in APIError.serverError }
                .map { $0.data }
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { _ in APIError.parsingError }
                .eraseToAnyPublisher()
        }
    
    /// Constroi a request.
    /// - Parameters:
    ///   - endpoint: Define qual é a rota ao qual a request será realizada.
    ///   - method: Define o método implementado para a request.
    /// - Returns: `URLRequest` para dataTask.
    private func request(for endpoint: Endpoint, method: Method) -> URLRequest {
            let path = "\(baseURL)\(endpoint.rawValue)\(accessKey)"
            guard let url = URL(string: path)
                else { preconditionFailure("Bad URL") }
            
            var request = URLRequest(url: url)
            request.httpMethod = "\(method)"
            request.allHTTPHeaderFields = ["Content-Type": "application/json"]
            return request
        }
}
