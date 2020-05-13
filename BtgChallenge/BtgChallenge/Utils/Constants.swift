//
//  Constants.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

struct Constants {
    struct Networking {
        static let baseUrl = "http://api.currencylayer.com/"
        static let accessKey = "ce7cc9678c03f001a7066496d5d10455"
    }
    
    struct Errors {
        static let apiDefaultMessage = "Erro ao tentar se conectar com o servidor."
        static let failToBuildUrl = "Erro ao tentar montar a URL."
    }
}
