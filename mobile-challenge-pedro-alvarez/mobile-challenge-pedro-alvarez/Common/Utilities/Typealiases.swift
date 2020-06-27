//
//  Typealiases.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

typealias TableViewOutput = NSObject & UITableViewDataSource & UITableViewDelegate
typealias SimpleCallbackType = () -> Void
typealias DataResponseCallback = (APIProvider.DataResponse) -> ()
typealias CurrencyConvertionJSONCallback = (CurrencyConvertionResponse) -> ()
typealias CurrencyListJSONCallback = (CurrencyListResponse) -> ()
typealias CurrencyValueRelation = [String : Double]
typealias CurrencyNameRelation = [String : String]
