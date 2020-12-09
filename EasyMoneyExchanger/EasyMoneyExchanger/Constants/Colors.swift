//
//  Colors.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import Foundation
import UIKit

struct Colors {
    static let primaryColor = getColor(red: 59, green: 189, blue: 175, alpha: 1)
    static let secondaryColor = UIColor.systemGray5
    static let labelColor = UIColor.label
}

func getColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
    return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
}
