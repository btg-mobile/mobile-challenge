//
//  HomeRepository.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

final class HomeRepository {
    
    func fetchLive(_ completion: @escaping (_ quotes: Quotes?, _ error: String?) -> Void) {
        
        completion(nil,nil)
    }
    
    func fetchList(_ completion: @escaping (_ list: [String]?, _ error: String?) -> Void) {
        
        completion(nil,nil)
    }
}
