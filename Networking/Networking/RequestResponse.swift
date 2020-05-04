//
//  RequestResponse.swift
//  Networking
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

public struct RequestResponse: Hashable {
    public let data: Data?
    public let status: HTTPStatusCode
    public let request: URLRequest
}
