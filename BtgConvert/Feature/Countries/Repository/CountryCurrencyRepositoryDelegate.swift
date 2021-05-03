//
//  CountryCurrencyRepository.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 29/04/21.
//

import Foundation
import Alamofire

protocol CountryCurrencyRepositoryDelegate {
    func getCountriesCorrencies(completion: @escaping (Swift.Result<CountryCurrencyResponse, Error>) -> Void)
}
