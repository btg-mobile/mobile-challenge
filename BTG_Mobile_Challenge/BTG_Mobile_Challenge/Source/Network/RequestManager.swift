//
//  RequestManager.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

fileprivate struct NilCodable: Codable {
}

internal enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

internal enum TaskAnswer<T> {
    case result(T?, T?)
    case error(Error)
}


final class RequestManager: NetworkService {
    
    init() {
    }

    func createRequest(url: String, method: HttpMethods) -> NSMutableURLRequest? {
        guard let URL = URL(string: url) else {
            return nil
        }
        let request = NSMutableURLRequest(url: URL)
        request.httpMethod = method.rawValue
        return request
    }

    /**
     This function performs a get request and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter header: The request's header, separated by key and values.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    func getRequest(url: String, header: [String: String]? = nil, completion:
        ((TaskAnswer<Any>) -> Void)? = nil) {
        getRequest(url: url, decodableType: NilCodable.self, header: header, completion: completion)
    }

    /**
     This function performs a get request, transforms its answer into a Decodable, and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter header: The request's header, separated by key and values.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    private func getRequest<T: Decodable>(
        url: String,
        decodableType: T.Type,
        header: [String: String]? = nil,
        completion: ((TaskAnswer<Any>) -> Void)? = nil ) {

        //Creating a request and making sure it exists.
        guard let request = createRequest(url: url, method: .get) else {
            completion?(TaskAnswer.error(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        //Adding each header parameter to the request.
        for headerParam in header ?? [:] {
            request.addValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }

        //Creating the get task with the request, and executing it.
        createTask(request: request as URLRequest, decodableType: decodableType, completion: completion).resume()
    }

    /**
     This function creates a DataTask from a URL request, and when resumed, triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter request: The URL Request.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    func createTask<T: Decodable>(request: URLRequest, decodableType: T.Type, completion:
        ((TaskAnswer<Any>) -> Void)? = nil) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion?(TaskAnswer.result([:], [:]))
                return
            }
            do {
                if decodableType != NilCodable.self {
                    let response = try JSONDecoder().decode(decodableType, from: data)
                    completion?(TaskAnswer.result(response, [:]))
                } else {
                    completion?(TaskAnswer.result(data, [:]))
                }
            } catch let error as NSError {
                completion?(TaskAnswer.error(error))
            }
        }
        return task
    }
}
