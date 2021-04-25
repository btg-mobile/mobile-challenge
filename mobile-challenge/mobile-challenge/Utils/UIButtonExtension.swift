//
//  UIButtonExtension.swift
//  mobile-challenge
//
//  Created by Marcos Fellipe Costa Silva on 25/04/21.
//

import UIKit

extension UIButton {
    func rotateAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        })
    }
    
}
