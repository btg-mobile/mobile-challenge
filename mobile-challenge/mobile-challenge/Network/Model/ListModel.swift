//
//  ListModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

struct ListModel: DataModelProtocol {
    static let service: ServiceType = .list
    
    let success: Bool
    let currencies: [String:String]?
}
