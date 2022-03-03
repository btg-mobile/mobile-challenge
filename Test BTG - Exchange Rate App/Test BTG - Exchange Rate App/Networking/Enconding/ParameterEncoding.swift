//
//  ParameterEncoding.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 28/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - Typealias

public typealias Parameters = [String:Any]

// MARK: - Protocol

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

// MARK: - Enum

public enum ParameterEncoding {
    case urlEncoding
    case jsonEncoding
    case urlAndJsonEncoding
    
    public func encode(urlRequest: inout URLRequest,
                       bodyParameters: Parameters?,
                       urlParameters: Parameters?) throws {
        switch self {
        case .urlEncoding:
            guard let urlParameters = urlParameters else { return }
            try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
            
        case .jsonEncoding:
            guard let bodyParameters = bodyParameters else { return }
            try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
            
        case .urlAndJsonEncoding:
            guard let urlParameters = urlParameters,
                  let bodyParameters = bodyParameters else { return }
            try URLParameterEncoder.encode(urlRequest: &urlRequest, with: urlParameters)
            try JSONParameterEncoder.encode(urlRequest: &urlRequest, with: bodyParameters)
        }
    }
}

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameters enconding failed."
    case missingURL = "URL is nil."
}

