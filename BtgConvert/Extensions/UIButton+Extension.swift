//
//  UIButton+Extension.swift
//  BtgConvert
//
//  Created by Albert Antonio Santos Oliveira - AOL on 02/05/21.
//

import Foundation
import UIKit

extension UIButton {
    func setRadius(with value: Int) {
        self.layer.cornerRadius = CGFloat(value)
    }
}
