//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    private let exchangeView = ExchangeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(exchangeView)
        view.backgroundColor = .systemBackground
        setupConstraints()
    }

    private func setupConstraints(){
        NSLayoutConstraint.activate([
            exchangeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exchangeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            exchangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            exchangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
}

