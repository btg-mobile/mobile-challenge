//
//  ViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Gois on 12/06/21.
//

import UIKit

class ViewController<T: UIView>: UIViewController {

    var contentView: T {
        return view as! T
    }

    override func loadView() {
        view = T()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
