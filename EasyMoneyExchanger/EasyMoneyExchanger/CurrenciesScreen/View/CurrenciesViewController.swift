//
//  CurrenciesViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import UIKit

class CurrenciesViewController: UIViewController, Storyboarded {

    static func instantiate() -> Self? { return CurrenciesViewController() as? Self}
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = Colors.primaryColor
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onPressAdd))
        // Do any additional setup after loading the view.
    }

    @objc func onPressAdd() {

    }

    @IBAction func goToExchange(_ sender: Any) {
    }
}
