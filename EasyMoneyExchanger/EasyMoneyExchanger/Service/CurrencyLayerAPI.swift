//
//  CurrencyLayerAPI.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 09/12/20.
//

import Foundation

class CurrencyLayerAPI {

    let apiKey = "0db8ed878f9da1db0a2f1dc91f086f7e"

    // MARK: - Currency Rates
    func fetchCurrencyRates(url: URL, completion: @escaping (Result<RealtimeRates, Errors>) -> Void) {
        let decoder = JSONDecoder()
        //Handling Error
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(Result.failure(Errors.invalidEndpoint))
            print("FICOU NO 1")
            return
        }

        let queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        urlComponents.queryItems = queryItems

        //Handling Error
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
                //Handling Error
                completion(Result.failure(Errors.transportError(error)))
                print("FICOU NO 4")
                return
            }
        }.resume()
    }

    // MARK: - Supported Currencies

    func fetchSupportedCurrencies(url: URL, completion: @escaping (Result<SupportedCurrencies, Errors>) -> Void) {
        let decoder = JSONDecoder()

        //Handling Error
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(Result.failure(Errors.invalidEndpoint))
            print("FICOU NO 1")
            return
        }

        let queryItems = [URLQueryItem(name: "access_key", value: apiKey)]
        urlComponents.queryItems = queryItems
        //Handling Error
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
                let currencies = try decoder.decode(SupportedCurrencies.self, from: data!)
                completion(Result.success(currencies))
            } catch {
                //Handling Error
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
