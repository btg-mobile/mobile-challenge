//
//  ViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 07/12/20.
//

import UIKit

class ExchangeViewController: UIViewController, Storyboarded {

    static func instantiate() -> Self{return ExchangeViewController() as! Self}
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func goToSecondScreen(_ sender: Any) {
        
        coordinator?.goToCurrenciesScreen()
    }
    
}

