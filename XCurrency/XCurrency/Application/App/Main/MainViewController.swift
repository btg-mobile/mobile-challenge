//
//  MainViewController.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var firstCurrencyComponent: CurrencyComponent!
    @IBOutlet private weak var secondCurrencyComponent: CurrencyComponent!

    // MARK: - Attributes
    private var viewModel: MainViewModel

    // MARK: - Initializers
    init(mainViewModel: MainViewModel) {
        self.viewModel = mainViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Overrides
    override func viewDidLoad() {
        self.setupComponentsGestures()
        self.title = "Currency converter"
        super.viewDidLoad()
    }

    // MARK: - Private Methods
    private func setupComponentsGestures() {
        let firstGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnCurrencyComponent))
        let secondGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapOnSecondCurrencyComponent))
        self.firstCurrencyComponent.addGestureRecognizer(firstGesture)
        self.secondCurrencyComponent.addGestureRecognizer(secondGesture)
    }

    // MARK: - Objc Methods
    @objc private func tapOnCurrencyComponent() {
        self.viewModel.presentCurrencySelector(order: .first)
    }

    @objc private func tapOnSecondCurrencyComponent() {
        self.viewModel.presentCurrencySelector(order: .second)
    }
}

