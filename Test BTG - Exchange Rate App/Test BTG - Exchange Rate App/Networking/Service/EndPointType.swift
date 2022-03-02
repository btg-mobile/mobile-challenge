//
//  EndPointType.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 28/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

protocol EndPointType {
    var baseURL:    URL             { get }
    var path:       String          { get }
    var httpMethod: HTTPMethod      { get }
    var task:       HTTPTask        { get }
    var headers:    HTTPHeaders?    { get }
}
