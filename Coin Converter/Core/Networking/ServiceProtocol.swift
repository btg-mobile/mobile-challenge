//
//  ServiceProtocol.swift
//  Coin Converter
//
//  Created by Igor Custodio on 29/07/21.
//

import Foundation

protocol ServiceProtocol {
    func request(route: ApiRoute, completion: @escaping (Result) -> ())
}
