//
//  CountryCurrencyRepository.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 29/04/21.
//

import Foundation

final class CountryCurrencyRepository: CountryCurrencyRepositoryDelegate {
    func getCountriesCorrencies(completion: @escaping (Result<CountryCurrencyResponse, Error>) -> Void) {
        CountryCurrencyRequest().execute { response in
            switch response.result {
                case .success(_):
                    let decoder = JSONDecoder()
                    let responseSuccess: Swift.Result<CountryCurrencyResponse, Error> = decoder.decodeResponse(from: response)
                    completion(responseSuccess)
                case .failure(_):
                    let error = ResponseError(code: 500, message: "Ocorreu um erro ao carregar os países. Tente novamente mais tarde!")
                    completion(Result.failure(error))
            }
        }
    }
}
