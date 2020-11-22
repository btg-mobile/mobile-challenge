//
//  LiveModel.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import Foundation

struct LiveModel: DataModelProtocol {
    static let service: ServiceType = .live
    
    let success: Bool
    let timestamp: Double
    let quotes: [String:Double]?
}
