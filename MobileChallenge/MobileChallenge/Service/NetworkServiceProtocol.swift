//
//  NetworkServiceProtocol.swift
//  MobileChallenge
//
//  Created by Giovanna Bonifacho on 04/02/25.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(urlString: String) async throws -> Data
}
