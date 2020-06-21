//
//  CurrenciesListRequest.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class CurrenciesListRequest: CurrencyLayerRequest {
    
    override var endpoint: String {
        return "/list"
    }
    
}
