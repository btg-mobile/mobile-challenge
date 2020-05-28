//
//  Localizer.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import Foundation
class Localizer {
    static let sharedInstance = Localizer()
    
    lazy var localizableDictionary: NSDictionary! = {
        if let path = Bundle.main.path(forResource: "Constants", ofType: "plist") {
            return NSDictionary(contentsOfFile: path)
        }
        
        fatalError("Localizable file NOT found")
    }()
    
    func localize(string: String) -> String {
        var localizableGroup = localizableDictionary!
        let components = string.components(separatedBy: ".")
        
        for component in components {
            guard let localizedValue = localizableGroup[component] as? NSDictionary else {
                if let localizedString = localizableGroup[component] as? String {
                    return localizedString
                }
                assertionFailure("Missing translation for: \(string)")
                return ""
            }
            localizableGroup = localizedValue
        }
        
        guard let localizedString = localizableGroup["value"] as? String else {
            assertionFailure("Missing translation for: \(string)")
            return ""
        }
        
        return localizedString
    }
}

extension String {
    var localized: String {
        return Localizer.sharedInstance.localize(string: self)
    }
}

