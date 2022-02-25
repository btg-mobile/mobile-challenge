//
//  UIViewControllerExtension.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

extension UIViewController {
    
    func configureGradientLayer() {
        let gradient    = CAGradientLayer()
        let topColor    = UIColor.themeBlue
        let bottomColor = UIColor.themeLightBlue
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0, 1]
        view.layer.addSublayer(gradient)
        gradient.frame = view.frame
        
    }
}
