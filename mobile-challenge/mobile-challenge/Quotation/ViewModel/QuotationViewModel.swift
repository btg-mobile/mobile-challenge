//
//  QuotationViewModel.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

class QuotationViewModel {
    
    var quotation: Quotation?
    var manager: NetworkManager
    
    init(manager: NetworkManager) {
        self.manager = manager
    }
}

extension QuotationViewModel {
    func fetchQuotation(completion: @escaping (String)->()) {
        manager.request(service: NetworkServiceType.live, model: Quotation.self) { (result) in
            switch result {
            case .success(let quotation):
                self.quotation = quotation
                let brl = quotation.quotes["USDBRL"] ?? 0.0
                let resultMenssage = "1 USD -> BRL \(String(format: "%.2f", brl))"
                completion(resultMenssage)
            case .failure(let error):
                print(error.localizedDescription)
                completion("Error")
            }
        }
    }
}
