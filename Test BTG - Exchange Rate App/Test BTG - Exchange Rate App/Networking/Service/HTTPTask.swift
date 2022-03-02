//
//  HTTPTask.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 28/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Typealias

public typealias HTTPHeaders = [String:String]

// MARK: - Enum

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        addtionHeaders: HTTPHeaders?)
}
