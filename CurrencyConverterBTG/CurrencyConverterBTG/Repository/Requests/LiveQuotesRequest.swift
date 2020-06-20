//
//  LiveQuotesRequest.swift
//  CurrencyConverterBTG
//
//  Created by Silvia Florido on 20/06/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class LiveQuotesRequest: CurrencyLayerRequest {
    
    override var endpoint: String {
        return "/live"
    }
    
}
