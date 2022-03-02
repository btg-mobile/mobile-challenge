//
//  NetworkManager.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Enum

enum Result<String> {
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case development
    case production
}

enum NetworkResponse:String {
    case SUCCESS
    case UNEXPECTED_ERROR       = "Encountered unexpected error."
    case NO_DATA                = "Response return no data."
    case SERVER_UNREACHABLE     = "The server is unreachable at the moment."
    case UNABLE_TO_DECODE       = "Uneable to decode response."
    case BAD_REQUEST            = "The request could not be understood by the server ."
    case UNAUTHORIZED           = "The request requires user authentication."
    case NOT_FOUND              = "The server has not found anything matching the Request-URI."
    case INTERNAL_SERVER_ERROR  = "The server encountered an unexpected condition which prevented it from fulfilling the request."
}

// MARK: - Typealias

typealias ResultResponse<T> = (_ success: Bool, _ value: T?, _ error: Error?)-> Void

// MARK: - Struct

struct NetworkManager {
    
    // MARK: - Properties
    
    let environment: NetworkEnvironment = .development
    
    private let router = NetworkRouter<Api>()
    
    public static var shared : NetworkManager = NetworkManager()
    
    var environmentBaseURL: String {
        switch environment {
        case .development:
            return "https://btg-mobile-challenge.herokuapp.com/"
        default: return "https://btg-mobile-challenge.herokuapp.com/"
        }
    }
    
    // MARK: - Methods
    
    func handleNetworkResponse(_ response: URLResponse? = nil, _ data: Data? = nil, _ error: Error? = nil) -> Result<String> {
        if let error = error {
            print(error.localizedDescription)
            return Result.failure(NetworkResponse.UNEXPECTED_ERROR.rawValue)
        }
        guard let responseData = data else {
            return .failure(NetworkResponse.NO_DATA.rawValue)
        }
        do {
            let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200: return .success
                default:
                    return statusCodeNetworkResponse((jsonData as! [String:Any])["status"] as! Int)
                }
            } else {
                return .failure(NetworkResponse.SERVER_UNREACHABLE.rawValue)
            }
            
        } catch {
            print(error)
            return .failure(NetworkResponse.UNABLE_TO_DECODE.rawValue + "error:\(error.localizedDescription)")
        }
    }
    
    func statusCodeNetworkResponse(_ errorCode: Int) -> Result<String> {
        switch errorCode {
        case 200: return .success
        case 400: return .failure(NetworkResponse.BAD_REQUEST.rawValue)
        case 401: return .failure(NetworkResponse.UNAUTHORIZED.rawValue)
        case 404: return .failure(NetworkResponse.NOT_FOUND.rawValue)
        case 500: return .failure(NetworkResponse.INTERNAL_SERVER_ERROR.rawValue)
            
        default: return .failure(NetworkResponse.UNEXPECTED_ERROR.rawValue)
        }
    }
    
}

// MARK: - Making The Call

extension NetworkManager {
    
    func getExchange(completion: @escaping ResultResponse<ExchangeRateVO>) {
        router.request(.live) { (data, response, error) in
            let result = self.handleNetworkResponse(response, data, error)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    completion(false, nil, error)
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(ExchangeRateVO.self, from: responseData)
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print("JSON Data: \(jsonData)")
                    completion(true, apiResponse, error)
                } catch {
                    print(error.localizedDescription)
                    completion(false, nil, error)
                }
                break
            case .failure(let networkFailureError):
                print(networkFailureError)
                completion(false, nil, error)
                break
            }
            
        }
    }
    
    func getCurrencies(completion: @escaping ResultResponse<CurrenciesVO>) {
        router.request(.list) { (data, response, error) in
            let result = self.handleNetworkResponse(response, data, error)
            
            switch result {
            case .success:
                guard let responseData = data else {
                    return
                }
                do {
                    let apiResponse = try JSONDecoder().decode(CurrenciesVO.self, from: responseData)
                    print("API Response: \(apiResponse)")
                    let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print("JSON Data: \(jsonData)")
                    completion(true, apiResponse, error)
                } catch {
                    print(error.localizedDescription)
                    completion(false, nil, error)
                }
                break
            case .failure(let networkFailureError):
                print(networkFailureError)
                completion(false, nil, error)
                break
            }
            
        }
    }
}


