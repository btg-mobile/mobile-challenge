//
//  Requisitions.swift
//  Networking
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation
import Combine

public typealias R = Requisitions
public enum Requisitions {
    
    static var mockedResponse: Future<RequestResponse, RequestError>?
    
    enum Method: String {
        case get
        case post
    }
    
    public enum RequestError: Error, LocalizedError, CustomStringConvertible, Hashable {
        
        case unmapped(Error)
        case serverError(Error)
        case notHTTPURLResponse
        case unknownStatusCode(Int)
        case queryParameters(URL, [String : Any])
        case emptyResponse(URL)
        case decoding(Error)
        case urlEncoding(String)
        case conversionToData
        
        var localizedDescription: String {
            switch self {
            case .unmapped(let error): return error.localizedDescription
            case .notHTTPURLResponse: return "The response received isn't of type HTTPURLResponse."
            case .unknownStatusCode(let status): return "Unknown status code \(status)."
            case let .queryParameters(url, parameters): return "Unable to create query parameters \(parameters) for \(url)."
            case .emptyResponse(let url): return "The response from \(url) is empty."
            case .decoding(let error): return "Unable to decode: \(error)"
            case .urlEncoding(let string): return "Unable to url encode '\(string)'"
            case .conversionToData: return "Unable to convert to data."
            case .serverError(let error): return "An error happend in the server: \(error)"
            }
        }
        
        public var description: String {
            return self.localizedDescription
        }
        
        public static func == (lhs: Requisitions.RequestError, rhs: Requisitions.RequestError) -> Bool {
            return lhs.localizedDescription == rhs.localizedDescription
        }
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(localizedDescription)
        }
    }
    
    struct RequestResponse: Hashable {
        let data: Data?
        let status: HTTPStatusCode
        let request: URLRequest
    }
    
    struct RequestDecodedResponse<D: Decodable & Hashable>: Hashable {
        let data: D
        let status: HTTPStatusCode
        let request: URLRequest
    }
}

extension Requisitions {
    static func request(at url: URL, method: Method, headers: [String : String] = [:], queryParameters: [String : Any] = [:], body: Data? = nil) -> Future<RequestResponse, RequestError> {
        
        if let mockedResponse = self.mockedResponse {
            return mockedResponse
        }
        
        return Future { promise in
            
            guard let request = createRequest(url: url, method: method, headers: headers, queryParameters: queryParameters, body: body) else {
                promise(.failure(.queryParameters(url, queryParameters)))
                return
            }
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    promise(.failure(.unmapped(error)))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else { promise(.failure(.notHTTPURLResponse)); return }
                guard let status = HTTPStatusCode(rawValue: httpResponse.statusCode) else { promise(.failure(.unknownStatusCode(httpResponse.statusCode))); return }
                return promise(.success(RequestResponse(data: data, status: status, request: request)))
            }
            
            dataTask.resume()
        }
    }
}

extension Requisitions {
    static func get(from url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:]) -> Future<RequestResponse, RequestError> {
        return request(at: url, method: .get, headers: headers, queryParameters: queryParameters)
    }
    
    static func get<Response: Decodable & Hashable, Decoder: TopLevelDecoder>(from url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:], decoder: Decoder) -> AnyPublisher<RequestDecodedResponse<Response>, RequestError> where Decoder.Input == Data {
        
        return get(from: url, headers: headers, queryParameters: queryParameters)
            .decode(from: url, decoder: decoder)
            .mapError { $0 as? RequestError ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }
}

extension Requisitions {
    static func post(to url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:], body: Data? = nil) -> Future<RequestResponse, RequestError> {
        return request(at: url, method: .post, headers: headers, queryParameters: queryParameters, body: body)
    }
    
    static func post<Response: Decodable & Hashable, Decoder: TopLevelDecoder>(to url: URL, headers: [String : String] = [:], queryParameters: [String : Any] = [:], decoder: Decoder, body: Data? = nil) -> AnyPublisher<RequestDecodedResponse<Response>, RequestError> where Decoder.Input == Data {
        
        return post(to: url, headers: headers, queryParameters: queryParameters, body: body)
            .decode(from: url, decoder: decoder)
            .mapError { $0 as? RequestError ?? .unmapped($0) }
            .eraseToAnyPublisher()
    }
}


fileprivate extension Requisitions {
    static func createRequest(url: URL, method: Method, headers: [String : String], queryParameters: [String : Any], body: Data?) -> URLRequest? {
        guard let urlWithQueryParamaters = url.with(queryParameters: queryParameters) else { return nil }
        
        var request = URLRequest(url: urlWithQueryParamaters)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}

fileprivate extension Publisher where Output == R.RequestResponse {
    func decode<Response: Decodable, Decoder: TopLevelDecoder>(from url: URL, decoder: Decoder) -> Publishers.TryMap<Self, R.RequestDecodedResponse<Response>> where Decoder.Input == Data {
        return self.tryMap { response -> R.RequestDecodedResponse<Response> in
            guard let data = response.data else { throw R.RequestError.emptyResponse(url)  }
                do {
                    let decoded = try decoder.decode(Response.self, from: data)
                    return R.RequestDecodedResponse(data: decoded, status: response.status, request: response.request)
                } catch {
                    throw R.RequestError.decoding(error)
                }
        }
    }
}
