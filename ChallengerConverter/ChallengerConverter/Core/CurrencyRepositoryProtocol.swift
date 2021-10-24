//
//  CurrencyRepositoryProtocol.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 23/10/21.
//

import Foundation


protocol CurrencyRepositoryProtocol {
    func quotes(success: @escaping (([Quotes]) -> Void), fail: @escaping ((String) -> Void))
    func currecnyAvaliable(success: @escaping (([Currency]) -> Void), fail: @escaping ((String) -> Void))
}
