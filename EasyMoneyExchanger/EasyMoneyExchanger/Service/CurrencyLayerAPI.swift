//
//  CurrencyLayerAPI.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation

class CurrencyLayerAPI {

    let apiKey = "API_KEY"

    func fetchAPI(url: URL, completion: @escaping (Result<RealtimeRates, Errors>) -> Void) {
        print("PASSOU FETCH")
        let decoder = JSONDecoder()
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(Result.failure(Errors.invalidEndpoint))
            print("FICOU NO 1")
            return
        }

        let queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        urlComponents.queryItems = queryItems

        guard let queryUrl = urlComponents.url else {
            completion(Result.failure(Errors.invalidEndpoint))
            print("FICOU NO 2")
            return
        }

        URLSession.shared.dataTask(with: queryUrl) { (data, response, error) in
            //Handling Error
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(Result.failure(Errors.transportError(error)))
                print("FICOU NO 3")
                return
            }

            // Decoding JSON
            do {
                let quotes = try decoder.decode(RealtimeRates.self, from: data!)
                completion(Result.success(quotes))
            } catch {
                completion(Result.failure(Errors.transportError(error)))
                print("FICOU NO 4")
                return
            }
        }.resume()
    }
}

enum Errors: Error {
    case transportError(Error?)
    case invalidEndpoint
}
