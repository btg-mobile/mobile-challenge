//
//  ServiceError.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
struct ServiceError: Error, Codable {
    let httpStatus: Int
    let message: String
    let description: String?
}
