//
//  UIColor+Hex.swift
//  Coin Converter
//
//  Created by Igor Custodio on 27/07/21.
//

import UIKit

extension UIColor {
    public convenience init?(hex: String) {
        var r, g, b, a: CGFloat
        var hexNumber: UInt64 = 0
        var hexColor = hex
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        }
        
        let scanner = Scanner(string: hexColor)
        
        switch hexColor.count {
            case 6:
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                    g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                    b = CGFloat((hexNumber & 0x0000ff)) / 255
                    a = CGFloat(1)
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
                return nil
            case 8:
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
                return nil
            default:
                return nil
        }
    }
}
