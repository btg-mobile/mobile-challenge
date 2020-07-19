//
//  UIView+Extension.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Custom layouts
extension UIView {
    func setCardLayout() {
        self.layer.shadowColor = UIColor.colorGrayLighten60.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
    }
}
