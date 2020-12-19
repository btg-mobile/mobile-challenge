//
//  ServiceMock.swift
//  BTG_Mobile_ChallengeTests
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import Foundation
@testable import BTG_Mobile_Challenge


final class ServiceMock: NetworkService {

    let bundle: Bundle
    var json: URL?
    
    var shouldFail: Bool = false
    var invalidCodable: Bool = false
    var unexpectedResponseType: Bool = false
    var missinData: Bool = false
    
    var statusCode: Int = 200
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func createTask<T>(request: URLRequest, decodableType: T.Type, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask where T : Decodable {
        
        if shouldFail {
            completion(nil, nil, PurposefulError(title: nil, description: "Request to fail"))
            return ServiceMockDataTask()
        }
        
        if unexpectedResponseType {
            completion(nil, nil, nil)
            return ServiceMockDataTask()
        }
        
        let urlResponse = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)

        if statusCode != 200 {
            completion(nil, urlResponse, nil)
            return ServiceMockDataTask()
        }
        
        if missinData {
            completion(nil, urlResponse, nil)
            return ServiceMockDataTask()
        }
        
        let data = try! Data(contentsOf: json!)
        completion(data, urlResponse, nil)
        
        return ServiceMockDataTask()
    }
}
