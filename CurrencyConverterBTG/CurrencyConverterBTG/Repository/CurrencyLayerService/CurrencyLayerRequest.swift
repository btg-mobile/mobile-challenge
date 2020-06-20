//
//  CurrencyLayerRequest.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class CurrencyLayerRequest: BaseRequest {
    let accessKey = "6e9a7ae3ac297c67a06197109c00ea2d"
    
    var rawUrl: String {
        get {
            return "http://api.currencylayer.com\(endpoint)?access_key=\(accessKey)"
        }
    }
    
    var endpoint: String {
        get {
            return ""
        }
    }
    
    var method: HTTPMethod {
        get {
            return .get
        }
    }
    
    var body: [String : Any]?
    
    var headers: [String : String]? = nil
    
}
