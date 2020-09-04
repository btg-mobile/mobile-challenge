//
//  CurrencyListServiceProvider.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Foundation

class CurrencyListServiceProvider: CurrencyListServiceProtocol {

    let url = "http://api.currencylayer.com/list"

    func fetchCurrencyList(completion: @escaping CurrencyListServiceCallback) {
        DispatchQueue.main.async {
            if let urlComponents = NSURLComponents(string: self.url) {
                urlComponents.queryItems = [URLQueryItem(name: "access_key", value: ApiKey.currencyApiKey)]
                if let url = urlComponents.url {
                    var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: .infinity)
                    request.httpMethod = "POST"

                    URLSession.shared.dataTask(with: request) { data, response, error in
                        if error != nil {
                            completion(.failure(error!))
                            return
                        }
                        guard let data = data else {
                            completion(.failure(URLError.cannotDecodeRawData as! Error))
                            return
                        }
                        do {
                            let decodedData = try JSONDecoder.init().decode(CurrencyListModel.self, from: data)
                            if decodedData.error != nil, decodedData.error?.info != nil  {
                                completion(.failure(ApiError.genericError(errorDescription: (decodedData.error?.info)!)))
                                return
                            }
                            completion(.success(decodedData))
                            return
                        } catch(let error) {
                            completion(.failure(error))
                            return
                        }
                    }.resume()
                }
            }
        }
    }
}
