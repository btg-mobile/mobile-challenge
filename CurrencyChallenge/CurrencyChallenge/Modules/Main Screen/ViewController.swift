//
//  ViewController.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import UIKit

class ViewController: UIViewController {
    
    private var sessionProvider: URLSessionProvider = URLSessionProvider()
    
    private var supportedCurrencies : RealTimeRates!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        sessionProvider.request(type: RealTimeRates.self, service: CurrencyService.live) { (response) in
            
            switch response {
            case let .success(response):
                self.supportedCurrencies = response
            case let .failure(error):
                print(error)
            }
            
        }
        
    }


}

