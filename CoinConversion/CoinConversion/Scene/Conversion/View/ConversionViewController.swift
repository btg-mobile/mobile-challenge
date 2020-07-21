//
//  ConversionViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

// MARK: - Main
class ConversionViewController: UIViewController {
    @IBOutlet private weak var fromCurrencyNameLabel: UILabel!
    @IBOutlet private weak var fromCurrencyCodeLabel: UILabel!
    
    @IBOutlet private weak var fromView: UIView! {
        didSet {
            fromView.setCardLayout()
            fromViewTapGestureRecognizer(fromView)
        }
    }
    
    @IBOutlet private weak var fromWithCurrencyView: UIView! {
        didSet {
            fromWithCurrencyView.isHidden = true
            fromWithCurrencyView.setCardLayout()
            fromViewTapGestureRecognizer(fromWithCurrencyView)
        }
    }
    
    @IBOutlet private weak var fromSeparatorView: UIView! {
        didSet {
            fromSeparatorView.backgroundColor = .colorGrayLighten60
        }
    }
    
    @IBOutlet private weak var toCurrencyNameLabel: UILabel!
    @IBOutlet private weak var toCurrencyCodeLabel: UILabel!
    
    @IBOutlet private weak var toView: UIView! {
        didSet {
            toView.setCardLayout()
            toViewTapGestureRecognizer(toView)
        }
    }
    
    @IBOutlet private weak var toWithCurrencyView: UIView! {
        didSet {
            toWithCurrencyView.isHidden = true
            toWithCurrencyView.setCardLayout()
            toViewTapGestureRecognizer(toWithCurrencyView)
        }
    }
    
    @IBOutlet private weak var toSeparatorView: UIView! {
        didSet {
            toSeparatorView.backgroundColor = .colorGrayLighten60
        }
    }
    
    @IBOutlet private weak var conversionStackView: UIStackView! {
        didSet {
            conversionStackView.isHidden = true
        }
    }
    
    @IBOutlet private weak var valeuView: UIView! {
        didSet {
            valeuView.setCardLayout()
        }
    }
    
    @IBOutlet private weak var resultView: UIView! {
        didSet {
            resultView.setCardLayout()
        }
    }
    
    var viewModel: ConversionViewModel?
    
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ConversionViewController.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UIViewController lifecycle
extension ConversionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .colorBackground
        
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .colorDarkishPink,
                               tintColor: .white,
                               title: "Conversão",
                               preferredLargeTitle: true,
                               isSearch: false,
                               searchController: nil
        )
        setupBarButton()
        viewModel?.delegate = self
        viewModel?.fetchQuotes()
    }
}

// MARK: - Private methods
extension ConversionViewController {
    @objc private dynamic func refreshButtonTouched() {
        viewModel?.fetchQuotes()
    }
    
    private func toViewTapGestureRecognizer(_ view: UIView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizedToView(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
    private func fromViewTapGestureRecognizer(_ view: UIView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizedFromView(sender:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private dynamic func tapGestureRecognizedToView(sender: UITapGestureRecognizer) {
        viewModel?.fetchCurrencies(.to)
    }
    
    @objc private dynamic func tapGestureRecognizedFromView(sender: UITapGestureRecognizer) {
        viewModel?.fetchCurrencies(.from)
    }
    
    private func setupBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(self.refreshButtonTouched))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
}

// MARK: - ConversionViewModelDelegate
extension ConversionViewController: ConversionViewModelDelegate {
    func didStartLoading() {
        showActivityIndicator()
    }
    
    func didHideLoading() {
        hideActivityIndicator()
    }
    
    func didReloadData(code: String, name: String, conversion: Conversion) {
        switch conversion {
        case .from:
            fromView.isHidden = true
            fromWithCurrencyView.isHidden = false
            fromCurrencyNameLabel.text = name
            fromCurrencyCodeLabel.text = code
        case .to:
            toView.isHidden = true
            toWithCurrencyView.isHidden = false
            fromCurrencyCodeLabel.text = code
            fromCurrencyNameLabel.text = name
        }
        
        if fromView.isHidden && toView.isHidden {
            conversionStackView.isHidden = false
        }
        
    }
    
    func didFail() {
    }
}
