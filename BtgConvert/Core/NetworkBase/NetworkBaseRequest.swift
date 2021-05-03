//
//  NetworkBaseRequest.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 29/04/21.
//

import Foundation
import Alamofire

// MARK: - Initialization

open class NetworkBaseRequest<Result: Decodable, DefaultError: Decodable>: NetworkRequestBase<Result, DefaultError> {
    override public init() {
        super.init()
    }
}

// MARK: - NetworkRequestBase

open class NetworkRequestBase<Success: Decodable, DefaultError: Decodable> {
    
    var baseUrl: String = "http://api.currencylayer.com"
    var path: String = ""
    
    public init() {}
    
    open func set(path: String) {
        self.path = path
    }
    
    public final func execute(completionHandler: @escaping (DataResponse<Data>) -> Void) {
        let request = AF.request(baseUrl + "" + path, method: .get)
        request.responseData { (response) in
            completionHandler(response)
        }
    }
    
}
