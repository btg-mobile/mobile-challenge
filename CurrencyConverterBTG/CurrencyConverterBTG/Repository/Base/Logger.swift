//
//  Logger.swift
//
//  Created by Silvia Florido on 31/05/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation

class Logger {
    public static func logRequest(_ request: URLRequest) {
        print("---------------------")
        
        if let url = request.url?.absoluteString {
            print("📤 Request: \(request.httpMethod!) \(url)")
        }
        
        if let headers = request.allHTTPHeaderFields {
            self.logHeaders(headers as [String : AnyObject])
        }
        
        if let httpBody = request.httpBody {
            do {
                let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                    print("JSON: \(string)")
                }
            }catch {
                if let string = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue) {
                    print("Data: \(string)")
                }
            }
        }
    }
    
    public static func logResponse(_ response: URLResponse?, data: Data? = nil) {
        print("---------------------")

        if let response = response {
            
            if let url = response.url?.absoluteString {
                print("📥 Response: \(url)")
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                let localizedStatus = HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode).capitalized
                print("Status: \(httpResponse.statusCode) - \(localizedStatus)")
                
                if let headers = httpResponse.allHeaderFields as? [String: AnyObject] {
                   logHeaders(headers)
                }
            }
            
            guard let data = data else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let pretty = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                
                if let string = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
                    print("JSON: \(string)")
                }
            }
                
            catch {
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    print("Data: \(string)")
                }
            }
        } else {
            print("📥 Response: nil ")
        }
    }
    
    public static func logHeaders(_ headers: [String: AnyObject]) {
        print("Headers: [")
        for (key, value) in headers {
            print("  \(key) : \(value)")
        }
        print("]")
    }
}
