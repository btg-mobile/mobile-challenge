//
//  Networking.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol Networking {
    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                             completion: @escaping (Result<T, Error>) -> Void)
}
