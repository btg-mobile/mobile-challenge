//
//  CurrencyViewController.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    weak var coordinator:MainCoordinator?
    
    let baseView = CurrencyView()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
