//
//  RealTimeRatesViewModel.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import Foundation

final class RealTimeRatesViewModel {
    
    private let api: RealTimeRatesApiProtocol
    private var model: RealTimeRatesModel?
    
    init(api: RealTimeRatesApiProtocol = RequestApi()) {
        self.api = api
    }
    
    var modelDetails: RealTimeRatesModel?  {
        return model
    }
    
    func fetchDetails(_ completion: @escaping (Bool) -> Void) {
        api.fetchRealTimeRates { statusCode, model in
            guard let statusCode = statusCode else { return }
            if ConnectionErrorManager.isSuccessfulStatusCode(statusCode: statusCode) {
                guard let model = model else { return }
                self.model = model
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
