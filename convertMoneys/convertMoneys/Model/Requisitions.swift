//
//  Requisitions.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation


protocol ObserverRequest {
    func notifyEndRequest(_ dicionary:[String:Double])
}

class Request:ObserverRequest {
    
    var allObservers:[ObserverRequest] = []
    
    func notifyEndRequest(_ dicionary:[String:Double]) {
        for observer in allObservers {
            observer.notifyEndRequest(dicionary)
        }
    }
    
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
       
    func dataForParse(data:Data) {
        do {
            let decoder = JSONDecoder()
            let decode = try decoder.decode(Currencies.self, from: data)
//            print(decode.quotes)
            notifyEndRequest(decode.quotes)
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    
}
