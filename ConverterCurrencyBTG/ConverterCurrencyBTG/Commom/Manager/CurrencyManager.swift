//
//  CurrencyManager.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation


class CurrencyManager {
    
    @discardableResult
    private func performRequest(route: CurrencyRouter, completion: @escaping (DataResponse) -> Void) -> URLSessionDataTask {
        let session = URLSession(configuration: .ephemeral)
        let request = try! route.asURLRequest()
        let dataTask =  session.dataTask(with:request) { (data, response, error) in
            let dataResponse =  DataResponse(request: request, response: response, data: data, error: error)
            completion(dataResponse)
            
        }
        
        dataTask.resume()
        return dataTask
    }
    
    @discardableResult
    func fetchList(route: CurrencyRouter = .list, completion: @escaping  (Result<ListCurrenciesModel, Error>) -> Void) -> URLSessionTask {
        return performRequest(route: route) { (dataresponse) in
            if let error = dataresponse.error {
                completion(.failure(error))
                return
            }
            guard let data = dataresponse.data, let listModel: ListCurrenciesModel = self.decodeParse(jsonData: data) else {
                return
            }
            completion(.success(listModel))
        }
    }
    
    func currencyQuotes(completion: @escaping  (Result<ListQuotes, Error>) -> Void) {
        performRequest(route: .live) { (dataresponse) in
            if let error = dataresponse.error {
                completion(.failure(error))
                return
            }
            guard let data = dataresponse.data, let listModel: ListQuotes = self.decodeParse(jsonData: data) else {
                return
            }
            completion(.success(listModel))
        }
    }
    
    
    fileprivate func decodeParse<T: Codable>(jsonData: Data) -> T? {
        do {
            let decoder = JSONDecoder()
            let items = try decoder.decode(T.self, from: jsonData)
            return items
        } catch(let error) {
            print(error)
            return nil
        }
    }
}

public struct DataResponse {
    public let request: URLRequest?
    public let response: URLResponse?
    public let data: Data?
    public let error: Error?
    
}


//# Dolar pra real
//# quantidade_em_dolar = 7
//# quantidade_em_real = None
//# def converter_dolar_pra_real(valor_dol):
//#     return valor_dol * cot.get("USDBRL")
//# print(f"O valor de {quantidade_em_dolar} dolares em real é: {converter_dolar_pra_real(valor_dol=quantidade_em_dolar)}")
//cot = {
//    "USDBRL": 5.36019,
//    "USDEUR": 0.889777,
//    "USDAED": 3.67250
//}
//# def converter_euro_pra_real(quantidade_de_euros_pra_converter): # Origem == minha moeda // alvo == moeda que eu quero
//#     valor_de_um_dolar_em_euros = cot.get("USDEUR")
//#     valor_em_dolares = quantidade_de_euros_pra_converter / valor_de_um_dolar_em_euros
//#     return valor_em_dolares * cot.get("USDBRL")
//quantidade_em_euro = 4
//def converter_origem_pra_alvo(moeda_de_origem="USDEUR", quantidade_de_origem=0, alvo="USDBRL"): # Origem == minha moeda // alvo == moeda que eu quero
//    valor_de_um_dolar_em_origem = cot.get(moeda_de_origem)
//    valor_da_origem_convertido_em_dolares = quantidade_de_origem / valor_de_um_dolar_em_origem
//    return round(valor_da_origem_convertido_em_dolares * cot.get(alvo), 2)
//print(f'O valor de {quantidade_em_euro} na moeda alvo é: {converter_origem_pra_alvo("USDEUR", 4, "USDBRL")}')
