//
//  Repository.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation

protocol Repository {
    
}

extension Repository {
    func performRequest(endpoint: String, success: @escaping (_ data: Data) -> Void, failure: @escaping (_ error: String) -> Void) {
        let session = URLSession.shared
        if let url = URL(string: Constants.Networking.baseUrl + endpoint + "?access_key=" + Constants.Networking.accessKey) {
            let task = session.dataTask(with: url, completionHandler: { data, response, error in
                if error != nil {
                    failure(error?.localizedDescription ?? Constants.Errors.apiDefaultMessage)
                }
                
                if let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) {
                    if let data = data {
                        print(data)
                        success(data)
                    }
                }
            })
            
            task.resume()
        } else {
            failure(Constants.Errors.failToBuildUrl)
        }
    }

}
