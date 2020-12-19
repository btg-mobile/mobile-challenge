//
//  String+ContainsDecimalSeparator.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 19/12/20.
//

import Foundation

extension String {
    func containsDecimalSeparator() -> Bool {
        return self.contains(".") || self.contains(",")
    }
}
