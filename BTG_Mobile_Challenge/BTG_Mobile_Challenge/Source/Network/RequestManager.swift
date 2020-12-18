//
//  RequestManager.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 18/12/20.
//

import Foundation

fileprivate struct NilCodable: Codable {
}

public enum HttpMethods: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

public enum TaskAnswer<T> {
    case result(T)
    case error(Error)
}


final class RequestManager {
    
    private init() {
    }

    private static func createRequest(url: String, method: HttpMethods) -> NSMutableURLRequest? {
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
    public static func getRequest(url: String, header: [String: String]? = nil, completion: ((TaskAnswer<Any>) -> Void)? = nil) {
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
    public static func getRequest<T: Decodable>(
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
     This function performs a post request, and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter method: The http method in the request.
     - Parameter header: The request's header, separated by key and values.
     - Parameter params: The reques's body, separated by key and values.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    public static func postRequest(
        url: String,
        method: HttpMethods = .post,
        header: [String: String]? = nil,
        params: [String: Any],
        completion: ((TaskAnswer<Any>) -> Void)? = nil) {
        postRequest(url: url, params: params, decodableType: NilCodable.self, completion: completion)
    }

    /**
     This function performs a post request, transforms its answer into a Decodable, and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter method: The http method in the request.
     - Parameter header: The request's header, separated by key and values.
     - Parameter params: The request's body, separated by key and values.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    public static func postRequest<T: Decodable>(
        url: String,
        method: HttpMethods = .post,
        header: [String: String]? = nil,
        params: [String: Any],
        decodableType: T.Type,
        completion: ((TaskAnswer<Any>) -> Void)? = nil) {

        //Creating a request and making sure it exists.
        guard let request = createRequest(url: url, method: method) else {
            completion?(TaskAnswer.error(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        //Adding each header parameter to the request.
        for headerParam in header ?? [:] {
            request.addValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }

        //Transforming the parameters into a string and putting into the httpBody.
        let postString = params.percentEscaped()
        request.httpBody = postString.data(using: String.Encoding.utf8)

        //Creating the post task with the request, and executing it.
        createTask(request: request as URLRequest, decodableType: decodableType, completion: completion).resume()
    }

    /**
     This function performs a post request, transforms its answer into a Decodable, and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter method: The http method in the request.
     - Parameter header: The request's header, separated by key and values.
     - Parameter params: The request's body, separated by key and values.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    public static func postRequest<P: Encodable>(
        url:String,
        method: HttpMethods = .post,
        header: [String: String]? = nil,
        params: P,
        completion: ((TaskAnswer<Any>) -> Void)? = nil) {
        guard let request = createRequest(url: url, method: method) else {
            completion?(TaskAnswer.error(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        //Adding each header parameter to the request.
        for headerParam in header ?? [:] {
            request.addValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }

        //Encoding the parameter to the httpBody.
        do {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            completion?(TaskAnswer.error(InvalidCodableError(title: nil, description: "Couldn't encode object to JSON")))
        }

        //Creating the post task with the request, and executing it.
        createTask(request: request as URLRequest, decodableType: NilCodable.self, completion: completion).resume()
    }

    /**
     This function performs a post request, transforms its answer into a Decodable, and triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter url: The url address to make the requisition.
     - Parameter method: The http method in the request.
     - Parameter header: The request's header, separated by key and values.
     - Parameter params: The request's body, which conforms to the encodable protocol.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    public static func postRequest<T: Decodable, P: Encodable>(
        url:String,
        method: HttpMethods = .post,
        header: [String: String]? = nil,
        params: P,
        decodableType: T.Type,
        completion: ((TaskAnswer<Any>) -> Void)? = nil) {

        //Creating a request and making sure it exists.
        guard let request = createRequest(url: url, method: method) else {
            completion?(TaskAnswer.error(NotURLError(title: nil, description: "Couldn't parse argument to URL")))
            return
        }

        //Adding each header parameter to the request.
        for headerParam in header ?? [:] {
            request.addValue(headerParam.value, forHTTPHeaderField: headerParam.key)
        }

        //Encoding the parameter to the httpBody.
        do {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try JSONEncoder().encode(params)
        } catch {
            completion?(TaskAnswer.error(InvalidCodableError(title: nil, description: "Couldn't encode object to JSON")))
        }

        //Creating the post task with the request, and executing it.
        createTask(request: request as URLRequest, decodableType: decodableType, completion: completion).resume()
    }

    /**
     This function creates a DataTask from a URL request, and when resumed, triggers a completion handler with its answer.

     - Warning: This method is asyncronous.

     - Parameter request: The URL Request.
     - Parameter decodableType: The decodable type that conforms to the get request answer.
     - Parameter completion: The block of code that will execute after the get request is executed.
     */
    public static func createTask<T: Decodable>(request: URLRequest, decodableType: T.Type, completion:
        ((TaskAnswer<Any>) -> Void)? = nil) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion?(TaskAnswer.result([:]))
                return
            }
            do {
                if decodableType != NilCodable.self {
                    let response = try JSONDecoder().decode(decodableType, from: data)
                    completion?(TaskAnswer.result(response))
                } else {
                    completion?(TaskAnswer.result(data))
                }
            } catch let error as NSError {
                completion?(TaskAnswer.error(error))
            }
        }
        return task
    }
}
