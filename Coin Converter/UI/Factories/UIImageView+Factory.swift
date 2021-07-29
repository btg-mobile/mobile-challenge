//
//  UIImageView+Factory.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import UIKit

extension UIImageView {
    static func createImageView(with imageName: String) -> UIImageView {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: imageName)
        
        return imageView
    }
}
