//
//  HomeRepository.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

final class HomeRepository {
    
    private var service: HomeService!
    
    init(_ service: HomeService = HomeService()) {
        self.service = service
    }
    
    func fetchLive(_ completion: @escaping (_ quotes: Quotes?, _ error: String?) -> Void) {
        service.fetchLive(success: { quotes in
            completion(quotes, nil)
        }) { error in
            completion(nil, error)
        }
    }
    
    func fetchList(_ completion: @escaping (_ currencies: Currencies?, _ error: String?) -> Void) {
        service.fetchList(success: { currencies in
            completion(currencies, nil)
        }) { error in
            completion(nil, error)
        }
    }
}
