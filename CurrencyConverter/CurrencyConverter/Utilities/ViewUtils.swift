//
//  ViewUtils.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import UIKit

public class ViewUtils {
    public static func alert(_ viewController: UIViewController, title: String? = nil, _ msg: String, btnLabel: String? = nil, completion: (() -> ())? = nil, onOK: (() -> ())? = nil) {
        DispatchQueue.main.async {
            let cancelButton = UIAlertAction(title: btnLabel ?? "OK", style: .default, handler: { action in
                onOK?()
            })
            let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            alert.addAction(cancelButton)
            viewController.present(alert, animated: true, completion: completion)
        }
    }
}
