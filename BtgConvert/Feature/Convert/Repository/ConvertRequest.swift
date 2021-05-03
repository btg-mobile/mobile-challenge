//
//  QuoteRequest.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 29/04/21.
//

import Foundation

class ConvertRequest: NetworkBaseRequest<QuoteResponse, DefaultError> {
    override init() {
        super.init()
        set(path: "/live?access_key=fc7bbb1a03dc65a08c4743fe369637fa")
    }
}
