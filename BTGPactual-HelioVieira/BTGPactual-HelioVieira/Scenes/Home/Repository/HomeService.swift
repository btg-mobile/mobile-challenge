//
//  HomeService.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

class HomeService {
    
    func search(_ term: String?, page: String, success: @escaping (Quotes) -> (), failure: @escaping (String) -> ()) {
        guard let term = term, let url = URL(string: String(format: "%@/live?access_key=a295966e84f3b52bce6ee2669d285028", BASE_URL, term, page)) else {
            failure("URL inválida!")
            return
        }
        Network.get(url: url) { (data, error) in
            if let error = error {
                failure(error)
            }

            do {
                guard let data = data else { return }
                let result = try JSONDecoder().decode(Quotes.self, from: data)
                success(result)
            } catch let err {
                failure(err.localizedDescription)
            }
        }
    }
}
