//
//  CurrencyChoosing.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol CurrencyChoosing: AnyObject {
    func chooseCurrency(type: CurrencyConverterViewModel.CurrencyType,
                        onSelect: @escaping (Currency) -> Void)
}
