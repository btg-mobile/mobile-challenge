//
//  UIViewControllerExtensions.swift
//  BTGConverterAPP
//
//  Created by Ana Caroline de Souza on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorMessage(message: String) {
        let ac = UIAlertController(title: "Error Occured!", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(ac,animated: true)
    }
}
