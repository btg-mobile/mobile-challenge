//
//  CurrencyConversionRequest.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 12/11/20.
//

import Foundation

private enum Constants {
    static let apiUrl = "convert"
}

struct CurrencyConversionRequest {
    static let sharedInstance: CurrencyConversionRequest = CurrencyConversionRequest()
    
    func convertCurrency(
        from: String,
        to: String,
        amount: String,
        success: @escaping (CurrencyConversionResponse?) -> Void,
        failure: @escaping (ErrorResponse?) -> Void) {
        
        let params = "from=\(from)&to=\(to)&amount=\(amount)"
        
        APIManager.sharedInstance.requestApi(
            apiUrl: Constants.apiUrl,
            params: params,
            handler: {data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(CurrencyConversionResponse.self, from: data)
                        success(response)
                    } catch let error {
                        debugPrint(error)
                        failure(ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
            })
    }
}
