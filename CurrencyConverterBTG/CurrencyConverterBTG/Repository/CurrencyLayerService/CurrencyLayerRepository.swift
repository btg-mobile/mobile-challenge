//
//  CurrencyLayerRepository.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class CurrencyLayerRepository {
    
    var session = URLSession.shared
    
    // MARK: Shared
    class func sharedInstance() -> CurrencyLayerRepository {
        struct Singleton {
            static var sharedInstance = CurrencyLayerRepository()
        }
        return Singleton.sharedInstance
    }
    
    func getQuotes(_ completionHandler: @escaping (_ response: [String]?, _ error: NSError?) -> Void) {
        let request = LiveQuotesRequest()
//        BaseRequester().taskForGETMethod(request: request, responseType: InfoResponse.self) { (response, error) in
//            if let response = response {
//                let gameInfo = GameInfo(response: response)
//                completionHandler(gameInfo, nil)
//            } else {
//                completionHandler(nil, error)
//            }
//        }
    }
}
