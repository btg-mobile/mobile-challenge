//
//  Helpers.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 04/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit

func inMainThread(_ callback: @escaping () -> Void) {
    DispatchQueue.main.async {
        callback()
    }
}

func alert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

    Router.shared.presentViewController(viewController: alert)
}

extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
