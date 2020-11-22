//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 22/11/20.
//

import UIKit

class ExchangeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let net = NetworkManager()
        net.request(model: ListModel.self) { (r) in
            
        }
        
        net.request(model: LiveModel.self) { (r) in
            
        }
        // Do any additional setup after loading the view.
    }


}

