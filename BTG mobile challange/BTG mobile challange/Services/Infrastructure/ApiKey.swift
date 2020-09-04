//
//  ApiKey.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 04/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

struct ApiKeyModel: Codable {
    var currencyApiKey: String
}

import Foundation

struct ApiKey {
    static var currencyApiKey: String {
        guard let apiKeyPlist = Bundle.main.path(forResource: "api_key", ofType: "plist") else { return "" }
        let dictionary = NSDictionary(contentsOfFile: apiKeyPlist)
        guard let value = dictionary?["currencyApiKey"] as? String else { return "" }
        return value
    }
}
