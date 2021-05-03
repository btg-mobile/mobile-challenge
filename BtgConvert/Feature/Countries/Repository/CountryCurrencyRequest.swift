//
//  CountryCurrencyRequest.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation

class CountryCurrencyRequest: NetworkBaseRequest<CountryCurrencyResponse, DefaultError> {
    override init() {
        super.init()
        set(path: "/list?access_key=fc7bbb1a03dc65a08c4743fe369637fa")
    }
}
