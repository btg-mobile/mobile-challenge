//
//  ExtensionUIViewController.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 29/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import RxSwift
import RxCocoa
import UIKit
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    
}
extension Reactive where Base: UIViewController {
    var animating: Binder<Bool> {
        return Binder(self.base) { vc, value in
            if value {
                vc.startAnimating()
                vc.view.isUserInteractionEnabled = false
            } else {
                vc.stopAnimating()
                vc.view.isUserInteractionEnabled = true
            }
        }
    }
}
