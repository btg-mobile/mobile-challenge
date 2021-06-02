//
//  DecodableExtension.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 30/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
extension Decodable {
    static var className: String {
        return String(describing: type(of: self))
    }
}
