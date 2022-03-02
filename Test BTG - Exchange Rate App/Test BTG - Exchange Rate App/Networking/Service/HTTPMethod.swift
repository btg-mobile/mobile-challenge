//
//  HTTPMethod.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 28/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

// MARK: - HTTPMethod

public enum HTTPMethod: String {
    case get    = "GET"
}

// MARK: - NetworkHeaderEnconding

public enum NetworkHeaderEnconding: String {
    case JSON       = "application/json"
    case ULREncoded = "application/x-www-form-urlencoded"
}
