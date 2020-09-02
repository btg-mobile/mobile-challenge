//
//  CurrencySelectorProtocol.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation
import RxSwift

protocol CurrencySelectorProtocol {
    var currencies: [Currency] { get set}
    var fistSelectedCurrency:  BehaviorSubject<Currency?> { get }
    var secondSelectedCurrency:  BehaviorSubject<Currency?> { get }
    
    func rx_currenciesList() -> Observable<[Currency]>
}
