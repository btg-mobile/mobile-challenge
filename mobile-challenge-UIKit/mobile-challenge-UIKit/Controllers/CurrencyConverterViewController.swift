//
//  CurrencyConverterViewController.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 14/12/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    @CurrencyTextField var originCurrencyTextField
    @CurrencyTextField var destinationCurrencyTextField

    var viewModel: CurrencyConverterViewModel?
    weak var coordinator: CurrencyChoosing?

    init(coordinator: CurrencyChoosing) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    private func setUp() {
        view.backgroundColor = .systemBackground

        viewModel = CurrencyConverterViewModel { [weak self] in
            self?.updateUI()
        }

        view.addSubview(originCurrencyTextField)
        NSLayoutConstraint.activate([
            originCurrencyTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            originCurrencyTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            originCurrencyTextField.heightAnchor.constraint(equalToConstant: 80),
            originCurrencyTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func updateUI() {

    }
}
