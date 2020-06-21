//
//  BaseRequester.swift
//
//  Created by Silvia Florido on 31/05/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation
import UIKit

class BaseRequester: NSObject {
    var session = URLSession.shared
    var debugMode = true
    
    let parseError = NSError(domain: "convertData", code: 1, userInfo: [NSLocalizedDescriptionKey: [NSLocalizedDescriptionKey : "Couldn't parsed the json results key."]])
    
    
    // MARK: - Base Requests
    func taskForGETMethod<T: Decodable>(request: BaseRequest, responseType: T.Type, completionHandlerForGET: @escaping (_ response: T?, _ error: NSError?) -> Void) {
        
        let urlRequest = request.asURLRequest()
        Logger.logRequest(urlRequest)
        
        let task = session.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                DispatchQueue.main.async {
                    completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
                }
            }
            guard error == nil else {
                let errorMessage = error?.localizedDescription ?? "Undefined error"
                sendError("There was an error with your request: \(errorMessage)")
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx")
                return
            }
            guard let data = data else {
                sendError("No data was returned by the request")
                return
            }
            
            do {
                let jsonResponse = try JSONDecoder().decode(T.self, from: data)
                if self.debugMode {
                    Logger.logResponse(response, data: data)
                }
                DispatchQueue.main.async {
                    completionHandlerForGET(jsonResponse, nil)
                }
            } catch {
                if self.debugMode {
                    Logger.logResponse(response, data: data)
                }
                DispatchQueue.main.async {
                    completionHandlerForGET(nil, self.parseError)
                }
            }
            
        }
        task.resume()
    }
    
    // MARK: - Query Parameters
    
    // BTG Test : Added this as an example if there were more parameters to add to service queries
    private func urlFromParameters(_ parameters: [String:AnyObject]?, pathExtension: String? = nil) -> URL? {
        var components = URLComponents()
//        components.scheme = CurrencyLayerService.Constants.ApiScheme
//        components.host = CurrencyLayerService.Constants.ApiHost
//        components.path = CurrencyLayerService.Constants.ApiPath + (pathExtension ?? "")
        components.queryItems = [URLQueryItem]()
        
        if let parameters = parameters {
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems?.append(queryItem)
            }
        }

        return components.url
    }
    
    
    func replaceKeysInMethod(_ method: String, keyValues: [String:String]) -> String?  {
        var mutableMethod = method
        
        for (key, value) in keyValues {
            if mutableMethod.range(of: "{\(key)}") != nil {
                mutableMethod = mutableMethod.replacingOccurrences(of: "{\(key)}", with: value)
            }
        }
        return mutableMethod
    }
    
    
    // MARK: - Images
    
    // BTG Test : Added this as an example if the flags images were to be downloaded
    static let cache = NSCache<NSString, UIImage>()
    
    static func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            DispatchQueue.main.async {
                completion(image)
            }
        } else {
            downloadImage(withURL: url, completion: completion)
        }
    }
    
    
    static func cacheImage(withURL url:URL, completion: @escaping (_ success: Bool)->()) {
        if let _ = cache.object(forKey: url.absoluteString as NSString) {
            print("Image already in cache for url: \(url.absoluteString)")
            completion(true)
        } else {
            downloadImage(withURL: url) { (image) in
                completion(image != nil)
            }
        }
    }
    
    
    static func downloadImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, responseURL, error in
            var downloadedImage:UIImage?
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            if let downloadedImage = downloadedImage {
                cache.setObject(downloadedImage, forKey: url.absoluteString as NSString)
                print("Cached image for url: \(url.absoluteString)")
            }
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }
        dataTask.resume()
    }
    
}
