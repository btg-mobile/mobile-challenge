//
//  LiveExchangeRequest.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 09/11/20.
//

import Foundation

private enum Constants {
    static let apiUrl = "live"
}

struct LiveExchangeRequest {
    static let sharedInstance: LiveExchangeRequest = LiveExchangeRequest()
    
    func getLiveExchange(
        success: @escaping (LiveExchangeResponse?) -> Void,
        failure: @escaping (ErrorResponse?) -> Void) {
        
        APIManager.sharedInstance.requestApi(
            apiUrl: Constants.apiUrl,
            params: nil,
            handler: {data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(LiveExchangeResponse.self, from: data)
                        success(response)
                    } catch let error {
                        debugPrint(error)
                        failure(ErrorResponse(code: -1, info: "Something went wrong"))
                    }
                }
            })
    }
}

extension URL {
    
    private static var accessKey: String {
        return "format=1&access_key=fc3775d337405138328142afae1cc260"
    }
    
    static func with(string: String, param: String? = nil) -> URL? {
        var url = "\(APIDns.baseUrl.dns)\(string)?\(accessKey)"
        if let param = param {
            url += "&\(param)"
        }
        return URL(string: url)
    }
    
}
