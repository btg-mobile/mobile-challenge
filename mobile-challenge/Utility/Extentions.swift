//
//  Extentions.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit


extension UITextField {
  
  func underlined() {
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = UIColor.lightGray.cgColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
  }
}

