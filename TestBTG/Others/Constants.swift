//
//  Constants.swift
//  TestBTG
//
//  Created by Renato Kuroe on 13/09/20.
//  Copyright © 2020 Renato Kuroe. All rights reserved.
//

import UIKit

struct Api {
      static let BASE_URL: String = "http://api.currencylayer.com";
      static let ACCESS_KEY: String = "?access_key=c8c87a9b1eecfa37f7ea4e74e27a1b36";
      static let URL_LIST: String = BASE_URL + "/list" + ACCESS_KEY;
      static let URL_LIVE: String = BASE_URL + "/live" + ACCESS_KEY;
  }

struct Variables {
    static let NO_CURRENCY_AVAILABLE: String = "Desculpe. As moedas escolhidas não estão disponíveis no modo offline. (A pesquisa por uma das moedas nunca foi feita por você anteriormente.)";
    static let NAV_TITLE: String = "Conversor de moedas";
    static let WARNING: String = "Aviso";
    static let OK: String = "OK";    
}
