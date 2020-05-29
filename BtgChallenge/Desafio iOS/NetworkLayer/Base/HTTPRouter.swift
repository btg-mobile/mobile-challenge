//
//  HTTPRouter.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
protocol HTTPRouter {
    var baseUrl: URL? { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: String] { get }
    var headers: [String: String]? { get }
}
