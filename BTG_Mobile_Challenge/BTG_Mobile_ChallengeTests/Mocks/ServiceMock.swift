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
    var jsonPath: URL?
    
    var shouldFail: Bool = false
    var invalidCodable: Bool = false
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func createTask<T>(request: URLRequest, decodableType: T.Type, completion: ((TaskAnswer<Any>) -> Void)?) -> URLSessionDataTask where T : Decodable {
        
        if shouldFail {
            completion?(TaskAnswer.error(RequestFailedError(title: nil, description: "Unable to complete the Request")))
            return ServiceMockDataTask()
        }
        
        if invalidCodable {
            completion?(TaskAnswer.error(InvalidCodableError(title: nil, description: "Codable was Invalid")))
            return ServiceMockDataTask()
        }
        
        guard let url = request.url, let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil) else {
            completion?(TaskAnswer.error(NotURLError(title: nil, description: "The URL was not valid")))
            return ServiceMockDataTask()
        }
        
        guard let json = jsonPath, let data = try? Data(contentsOf: json) else {
            completion?(TaskAnswer.error(RequestFailedError(title: nil, description: "Unable to complete the Request")))
            return ServiceMockDataTask()
        }
              
        completion?(TaskAnswer.result(response, data))
        return ServiceMockDataTask()
    }
    
}
