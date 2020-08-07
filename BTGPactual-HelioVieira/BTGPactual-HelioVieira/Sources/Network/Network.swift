//
//  Network.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import Foundation

//Custumo deixar a BASE_URL no "BuiderSettings", mas para simplicidade vou deixar aqui!
let BASE_URL = "http://api.currencylayer.com"

//Fiz essa camada de Networking simples, apenas para atender a esta demanda.
//Gosto de criar esse modulo Base de Network e uma interface para lidar com ela
//dentro de cada Cena, que chamo de camada de Serviço.
final class Network {
    
    static func get(url: URL, completion: @escaping (Data?, String?) -> Void) {
        debugPrint("==> Request GET: \(url.absoluteString)")
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(nil, err.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(nil, "Serviço indisponível!")
                return
            }
            
            completion(data, nil)
        }.resume()
    }
}
