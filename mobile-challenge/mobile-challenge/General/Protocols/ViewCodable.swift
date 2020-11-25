//
//  ViewCodableProtocol.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

protocol ViewCodable {
    func setUpViews()
    func setupHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}

extension ViewCodable {
    func setUpViews() {
        setupHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }
    
    func setupAditionalConfiguration() { }
}
