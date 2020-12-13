//
//  CurrencyConverterViewController.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 12/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    private lazy var contentView = CurrencyConverterView()
        .set(\.fromCurrencySelectButton.tapAction, to: didTapFromCurrency)
        .set(\.toCurrencySelectButton.tapAction, to: didTapToCurrency)
        .run {
            $0.swapButton.addTarget(self, action: #selector(didTapSwapButton), for: .touchUpInside)
        }
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        view = contentView
    }
    
    // MARK: - Life Cycle
    
    override func viewDidAppear(_ animated: Bool) {
        contentView.fromValueTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    
    func didTapFromCurrency() {
        print("fromCurrencySelectButton - tapped")
    }
    
    func didTapToCurrency() {
        print("toCurrencySelectButton - tapped")
    }
    
    @objc func didTapSwapButton() {
        print("swapButton - tapped")
    }
    
}
