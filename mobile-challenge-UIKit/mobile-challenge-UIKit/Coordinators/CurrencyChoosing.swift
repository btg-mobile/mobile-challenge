//
//  CurrencyChoosing.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import Foundation

protocol CurrencyChoosing: AnyObject {
    func chooseCurrency(onSelect: @escaping (Currency) -> Void)
}
