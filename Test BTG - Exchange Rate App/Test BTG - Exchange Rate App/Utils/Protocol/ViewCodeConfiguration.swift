//
//  ViewCodeConfiguration.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import Foundation

protocol ViewCodeConfiguration {
    func configureViews()
    func buildHierarchy()
    func setupConstraints()
}

extension ViewCodeConfiguration {
    
    func configureViews() {}
    
    func applyViewCode() {
        configureViews()
        buildHierarchy()
        setupConstraints()
    }
}
