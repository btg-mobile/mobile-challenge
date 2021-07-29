//
//  Environment.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import Foundation

enum EnvironmentVariables: String {
    case apiBaseUrl = "api"
}

final class Environment {
    
    static let shared = Environment()
    
    private let plist: String
    private let dict: NSDictionary
    
    private init() {
        plist = Bundle.main.path(forResource: "CoinConverter", ofType: "plist")!
        dict = NSDictionary(contentsOfFile: plist)!
    }
    
    func variable(_ key: EnvironmentVariables) -> String {
        return dict[key.rawValue] as! String
    }
}
