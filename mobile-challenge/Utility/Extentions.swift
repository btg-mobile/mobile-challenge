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

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension UIViewController {
  
  func showToast(message : String) {
    let fixedWidth = self.view.frame.size.width - ( (self.view.frame.size.width/8) * 2)
    let toastLabel = UITextView(frame: CGRect(x: self.view.frame.size.width/8, y: self.view.frame.size.height-100, width: fixedWidth, height: 35))
    toastLabel.backgroundColor = UIColor(named: "color_toast")
    toastLabel.textColor = UIColor.black
    toastLabel.textAlignment = .center;
    toastLabel.isEditable = false
    toastLabel.isScrollEnabled = false
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    let newSize = toastLabel.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
    toastLabel.frame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
      toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
      toastLabel.removeFromSuperview()
    })
  }
  
}

extension UIAlertController {
  func pruneNegativeWidthConstraints() {
    for subView in self.view.subviews {
      for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
        subView.removeConstraint(constraint)
      }
    }
  }
}

