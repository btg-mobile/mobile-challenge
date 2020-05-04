//
//  Service.swift
//  Service
//
//  Created by Gustavo Amaral on 03/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

public class Services {
    
    public static let `default` = Services()
    private var registers = [ObjectIdentifier : () -> Any]()
    
    public func register<S>(_ service: S.Type, maker: @escaping () -> S) {
        registers[ObjectIdentifier(service)] = maker
    }
    
    public func make<S>(_ service: S.Type) -> S {
        let id = ObjectIdentifier(service)
        guard let maker = registers[id] else {
            fatalError("Service '\(service)' wasn't previously registered")
        }
        guard let casted = maker() as? S else {
            fatalError("Service '\(service)' can't be downcasted to '\(S.self)'.")
        }
        return casted
    }
}
