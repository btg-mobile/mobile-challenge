//
//  Router.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import UIKit

class Router {
    public static let shared = Router()
    
    func setViewController(viewController: UIViewController) {
        let navigation = SceneDelegate.shared?.navigationVC
        navigation?.pushViewController(viewController, animated: true)
    }
}
