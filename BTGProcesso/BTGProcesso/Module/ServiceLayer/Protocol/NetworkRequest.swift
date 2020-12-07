//
//  NetworkRequest.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation


protocol NetworkRequestProtocol {
    
    var jsonDecode: JSONDecoder { get }
    
    func decode(data: Data) throws -> Quota 
}

extension NetworkRequestProtocol {
    
    var jsonDecode: JSONDecoder {
        JSONDecoder()
    }
}
