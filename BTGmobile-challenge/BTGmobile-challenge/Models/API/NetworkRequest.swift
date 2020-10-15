//
//  NetworkRequest.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 12/10/20.
//

import Foundation

class NetworkManager {
	func makeListRequest(url: String, completion: @escaping (Result<ListedCurrencyResponse, Error>) -> Void) {
		if let url = URL(string: url) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data {
					do {
						let res = try JSONDecoder().decode(ListedCurrencyResponse.self, from: data)
						DispatchQueue.main.async {
							completion(.success(res))
						}
						
					} catch let error {
						print(error)
					}
				}
			}.resume()
		}
	}
	
	func makeLiveRequest(url: String, completion: @escaping (Result<LiveCurrencyResponse, Error>) -> Void) {
		if let url = URL(string: url) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data {
					do {
						let res = try JSONDecoder().decode(LiveCurrencyResponse.self, from: data)
						DispatchQueue.main.async {
							completion(.success(res))
						}
						
					} catch let error {
						DispatchQueue.main.async {
							completion(.failure(error))
						}
					}
				} else {
//					let error: NSError = NSError(domain: "Erro ao capturar data", code: , userInfo: nil)
					DispatchQueue.main.async {
						completion(.failure(error!))
					}
				}
			}.resume()
		}
	}
	
	func get(url: String, completion: @escaping (Result<LiveCurrencyResponse, Error>) -> Void) {
		if let url = URL(string: url) {
			URLSession.shared.dataTask(with: url) { data, response, error in
				if let data = data {
					do {
						let res = try JSONDecoder().decode(LiveCurrencyResponse.self, from: data)
						DispatchQueue.main.async {
							completion(.success(res))
						}
						
					} catch let error {
						DispatchQueue.main.async {
							completion(.failure(error))
						}
					}
				} else {
//					let error: NSError = NSError(domain: "Erro ao capturar data", code: , userInfo: nil)
					DispatchQueue.main.async {
						completion(.failure(error!))
					}
				}
			}.resume()
		}
	}

}
