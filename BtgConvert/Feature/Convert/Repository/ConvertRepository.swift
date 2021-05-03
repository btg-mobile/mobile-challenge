//
//  ConvertRepository.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation

class ConvertRepository: ConvertRepositoryDelegate {
    func getQuotes(completationHandler: @escaping (Result<QuoteResponse, Error>) -> Void) {
        ConvertRequest().execute { response in
            switch response.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    let responseSuccess: Swift.Result<QuoteResponse, Error> = decoder.decodeResponse(from: response)
                    completationHandler(responseSuccess)
                case .failure(_):
                    let error = ResponseError(code: 500, message: "Ocorreu um erro ao carregar as cotas. Tente novamente mais tarde!")
                    completationHandler(Result.failure(error))
            }
        }
    }
}
