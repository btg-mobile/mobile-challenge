//
//  Requisitions.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation


protocol ObserverRequest {
    /**
     Notify the end of request for the class that call the peformRequest method
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter dicionary: Name currencie and your quote
     */
    func notifyEndRequest(_ dicionary:[String:Double])
}

class Request:ObserverRequest {
    
    ///All observers of this class
    var allObservers:[ObserverRequest] = []
    
    func notifyEndRequest(_ dicionary:[String:Double]) {
        for observer in allObservers {
            observer.notifyEndRequest(dicionary)
        }
    }
    
    /**
     Create a request and call method to parse
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter url: the URL for create a request
     */
    func peformRequest(url:String){
        if let urlRequest = URL(string: url){

            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: urlRequest) { (data, response, error)  in
                if error != nil{
                    fatalError("Error in Request")
                }
                
                if data?.isEmpty == false{
                    if let dataForParse = data{
                        self.dataForParse(data: dataForParse)
                    }
                }
            }
            task.resume()
        }
    }
    
    /**
     Method for parse of a JSON
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter data: A data object
     */
    func dataForParse(data:Data) {
        do {
            let decoder = JSONDecoder()
            let decode = try decoder.decode(Currencies.self, from: data)
            
            notifyEndRequest(decode.quotes)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    
}
