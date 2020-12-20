//
//  UIAlert+Extension.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import UIKit

extension UIAlertController {

    /**
     This method adds a single action to a UIAlertController that shows a log message when clicked, also setting the view's tint color to be the app's main color.
     - Parameter logMessage: A string containing the message to be displayed in the log.
     - Returns: The customised UIAlertController.
     */
    internal func makeErrorMessage(with logMessage: String) -> UIAlertController {
        let action = UIAlertAction(title: "Done", style: .default) { _ in
            NSLog(logMessage)
        }
        
        self.addAction(action)
        self.view.tintColor = .black
        
        return self
    }
}
