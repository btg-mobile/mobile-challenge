//
//  ViewController.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .red
        self.view.tintColor = .green
        
        let button = UIButton(frame: CGRect(x: 30, y: 30, width: 30, height: 30))
        button.tintColor = .gray
        button.backgroundColor = .brown
        self.view.addSubview(button)
        
        CurrencyLayerAPI.shared.fetchSupportedCurrencies{
            print("completed")
        }
    }


}

