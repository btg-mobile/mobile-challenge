//
//  Requisitions.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation

class Request {

    func peformRequest(url:String) -> Data?{
        if let urlRequest = URL(string: url){
            
            var responseReturn:Data?
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: urlRequest) { (data, response, error)  in
                if error != nil{
                    responseReturn = nil
                }

                responseReturn = data
            }
            
            task.resume()
            
            return responseReturn
        }
        return nil
    }
    
}
