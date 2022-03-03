//
//  JSONParameterEncoder.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 28/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

public struct JSONParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue(NetworkHeaderEnconding.JSON.rawValue, forHTTPHeaderField: "Content-Type")
            }
        }catch {
            throw NetworkError.encodingFailed
        }
    }
}
