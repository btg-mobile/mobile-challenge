//
//  NetworkServiceMock.swift
//  btg-mobile-challengeTests
//
//  Created by Artur Carneiro on 02/10/20.
// swiftlint:disable force_unwrapping
// swiftlint:disable force_try

import Foundation
@testable import btg_mobile_challenge

final class NetworkServiceMock: NetworkService {

    let bundle: Bundle

    var shouldFail: Bool = false
    var unexpectedHTTPResponse: Bool = false
    var statusCode: Int = 200

    init(bundle: Bundle) {
        self.bundle = bundle
    }

    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        if shouldFail == true {
            completionHandler(nil, nil, NetworkServiceError.requestFailed)
        }

        if unexpectedHTTPResponse == true {
            completionHandler(nil,
                              nil,
                              NetworkServiceError.unexpectedHTTPResponse)
        }

        let urlResponse = HTTPURLResponse(url: with.url!, statusCode: statusCode, httpVersion: nil, headerFields: nil)

        let json = bundle.url(forResource: "live-response", withExtension: "json")!

        let data = try! Data(contentsOf: json)

        completionHandler(data, urlResponse, nil)

        return NetworkServiceDataTaskMock()

    }

}
