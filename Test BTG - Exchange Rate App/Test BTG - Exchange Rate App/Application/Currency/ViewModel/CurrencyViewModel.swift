//
//  CurrencyViewModel.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

class CurrencyViewModel {
    
    // MARK: - Properties
    
    public var lisCurrencies: Bindable<[CurrencyModel]>
    public var isUpdateTable: Bindable<Bool>
}
