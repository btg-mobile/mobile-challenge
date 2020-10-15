//
//  NetworkRequest.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 12/10/20.
//

import Foundation

class NetworkManager {
	func request<T: Decodable> (type: T, url: String, completion: @escaping (Result<T, Error>) -> Void) {
		if let url = URL(string: url) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data {
					do {
						let res = try JSONDecoder().decode(T.self, from: data)
						DispatchQueue.main.async {
							completion(.success(res))
						}
						
					} catch let error {
						DispatchQueue.main.async {
							completion(.failure(error))
						}
					}
				} else {
					DispatchQueue.main.async {
						completion(.failure(error!))
					}
				}
			}.resume()
		} else {
			let error = NSError(domain: "connection error", code: 400, userInfo: nil)
			DispatchQueue.main.async {
				completion(.failure(error))
			}
		}
	}

}
