//
//  ConvertRepositoryDelegate.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 30/04/21.
//

import Foundation
import Alamofire

protocol ConvertRepositoryDelegate {
    func getQuotes(completationHandler: @escaping (Swift.Result<QuoteResponse, Error>) -> Void)
}
