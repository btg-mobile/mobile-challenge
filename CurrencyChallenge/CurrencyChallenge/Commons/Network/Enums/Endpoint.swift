//
//  Endpoint.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import Foundation

fileprivate let BASE_URL_KEY = "BASE_URL_KEY"
fileprivate let API_KEY = "API_KEY"

enum Endpoint {
    static func baseURL() -> URL {
        guard let basePath = Bundle.main.object(forInfoDictionaryKey: BASE_URL_KEY) else {
            fatalError("There's no value for key '\(BASE_URL_KEY)' in Info.plist file.")
        }
        guard let basePathStr = basePath as? String else {
            fatalError("The value for key '\(basePath)' isn't a string.")
        }
        guard let baseURL = URL(string: basePathStr) else {
            fatalError("The base URL '\(basePathStr)' isn't really a valid URL.")
        }
        return baseURL
    }
    
    static func apiKey() -> String {
        guard let apiPath = Bundle.main.object(forInfoDictionaryKey: API_KEY) else {
           fatalError("There's no value for key '\(API_KEY)' in Info.plist file.")
       }
       guard let apiStr = apiPath as? String else {
           fatalError("The value for key '\(apiPath)' isn't a string.")
       }
        return apiStr
    }
}
