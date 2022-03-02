//
//  Bindable.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 01/03/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

class Bindable<T> {
    
    // MARK: - Properties
    
    var observer: ((T?) -> ())?
    
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    // MARK: - Methods
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
