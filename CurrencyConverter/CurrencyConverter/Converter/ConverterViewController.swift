//
//  ConverterViewController.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 29/10/20.
//

import UIKit
import CurrencyServices

class ConverterViewController: UIViewController {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = CurrencyServices.hello
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        
        view.addSubview(label)
        label
            .top(anchor: view.topAnchor)
            .bottom(anchor: view.bottomAnchor)
            .leading(anchor: view.leadingAnchor)
            .trailing(anchor: view.trailingAnchor)
    }
}

