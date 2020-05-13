//
//  CoinConvertViewController.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class CoinConvertViewController: UIViewController {

    var coinConvertView: CoinConvertView?
    
    override func loadView() {
        super.loadView()
        coinConvertView = CoinConvertView()
        view = coinConvertView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Conversor de moedas"
        
//        let repository = TestRep()
//        repository.performRequest(endpoint: "live", success: { (data) in
//            print(data)
//        }) { (errorMessage) in
//            print(errorMessage)
//        }
        
        let provider = HTTPProvider<Router>()
        provider.request(router: .convert("USD", "GPB", "10.00"))
    }

}

class TestRep: Repository {
    
}
