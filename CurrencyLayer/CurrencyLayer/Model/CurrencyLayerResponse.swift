//
//  CurrencyLayerResponse.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 08/12/20.
//

import Foundation

public struct CurrencyLayerResponse: Decodable {
  var success: Bool
  var terms: String
  var privacy: String
  var timestamp: Int
  var source: String
  var quotes: [String:Double]
}

