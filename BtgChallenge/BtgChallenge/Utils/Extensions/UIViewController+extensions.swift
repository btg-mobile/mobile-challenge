//
//  UIViewController+extensions.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlert(message: String) {
        let alertController = UIAlertController(
            title: Constants.Strings.alertTitle,
            message: message,
            preferredStyle: .alert
        )
        
        alertController.addAction(
            UIAlertAction(
                title: Constants.Strings.alertButton,
                style: .default,
                handler: nil
            )
        )
        
        present(alertController, animated: true, completion: nil)
    }
}
