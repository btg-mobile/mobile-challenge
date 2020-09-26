//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 25/09/20.
//

import UIKit

protocol ConverterViewControllerCoordinator: AnyObject {
    func currencyListView()
}

class ConverterViewController: UIViewController, Storyboarded {
    
    weak var coordinator: ConverterViewControllerCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func originCurrrencyButton(_ sender: Any) {
        coordinator?.currencyListView()
    }
    
    @IBAction func destinyCurrencyButton(_ sender: Any) {
    }
    
}

