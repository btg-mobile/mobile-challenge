//
//  CurrencyListRequest.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 10/11/20.
//

import Foundation

private enum Constants {
    static let apiUrl = "list"
}

struct CurrentListRequest {
    static let sharedInstance: CurrentListRequest = CurrentListRequest()
    
    func getAllCurrencies(
        success: @escaping (CurrencyListResponse?) -> Void,
        failure: @escaping (ErrorResponse?) -> Void) {
        
        APIManager.sharedInstance.requestApi(
            apiUrl: Constants.apiUrl,
            params: nil,
            handler: {data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder()
                            .decode(CurrencyListResponse.self, from: data)
                        success(response)
                    } catch let error {
                        debugPrint(error)
                        failure(ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
            })
    }
}
