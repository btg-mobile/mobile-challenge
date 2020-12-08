//
//  ViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 07/12/20.
//

import UIKit

class ExchangeViewController: UIViewController, Storyboarded {

    static func instantiate() -> Self? {
        return ExchangeViewController() as? Self
    }

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

    // MARK: - Outlets

    @IBOutlet weak var currenciesListButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "list.bullet",
                withConfiguration: UIImage.SymbolConfiguration(weight: .black)
            )?.withTintColor(Colors.mainColor, renderingMode: .alwaysOriginal)
            currenciesListButton.setTitle("", for: .normal)
            currenciesListButton.setImage(buttonIcon, for: .normal)
        }
    }

    @IBOutlet weak var updateCurrencyButton: UIButton! {
        didSet {
            // Override Button Icon
            let buttonIcon = UIImage(
                systemName: "goforward", withConfiguration: UIImage.SymbolConfiguration(weight: .black)
            )?.withTintColor(Colors.mainColor, renderingMode: .alwaysOriginal)
            updateCurrencyButton.setTitle("", for: .normal)
            updateCurrencyButton.setImage(buttonIcon, for: .normal)
        }
    }

    // MARK: - Actions

    @IBAction func goToCurrenciesScreen(_ sender: Any) {
        coordinator?.goToCurrenciesScreen()
    }

    @IBAction func updateCurrencyValues(_ sender: Any) {
    }

}
