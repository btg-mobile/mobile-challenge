//
//  CurrencyConvertionViewController.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyConvertionViewController: UIViewController {
    
    private lazy var firstCurrencyButton: CurrencyButton = {
        let button = CurrencyButton(frame: .zero,
                                    title: Constants.Button.firstCurrencyButton)
        button.addTarget(self,
                         action: #selector(didTapFirstCurrencyButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var secondCurrencyButton: CurrencyButton = {
        let button = CurrencyButton(frame: .zero,
                                    title: Constants.Button.secondCurrencyButton)
        button.addTarget(self,
                         action: #selector(didTapSecondCurrencyButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var convertActionButton: ConvertActionButton = {
        let button = ConvertActionButton(frame: .zero)
        button.addTarget(self,
                         action: #selector(didTapConvertActionButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var resultLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var errorView: ErrorView = {
        let view = ErrorView(frame: .zero, errorMessage: .empty)
        return view
    }()
    
    private lazy var mainView: CurrencyConvertionView = {
        return CurrencyConvertionView(firstCurrencyButton: firstCurrencyButton,
                                      secondCurrencyButton: secondCurrencyButton,
                                      convertActionButton: convertActionButton,
                                      resultLbl: resultLbl,
                                      errorView: errorView)
    }()
    
    private var viewModel: CurrencyConvertionViewModelProtocol?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.fetchCurrencyValues()
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
}

extension CurrencyConvertionViewController {
    
    private func setupController() {
        title = Constants.Titles.convertionTitle
        self.viewModel = CurrencyConvertionViewModel(delegate: self)
    }
    
    @objc
    private func didTapFirstCurrencyButton() {
        let currentyListVC = CurrencyListViewController(finishCallback: {
            self.firstCurrencyButton.setTitle($0, for: .normal)
        })
        navigationController?.pushViewController(currentyListVC, animated: true)
    }
    
    @objc
    private func didTapSecondCurrencyButton() {
        let currentyListVC = CurrencyListViewController(finishCallback: {
            self.secondCurrencyButton.setTitle($0, for: .normal)
        })
        navigationController?.pushViewController(currentyListVC, animated: true)
    }
    
    @objc
    private func didTapConvertActionButton() {
        
    }
}

extension CurrencyConvertionViewController: CurrencyConvertionViewModelDelegate {
    
    func didFetchFirstCurrency(_ currency: String) {
        firstCurrencyButton.setTitle(currency, for: .normal)
    }
    
    func didFetchSecondCurrency(_ currency: String) {
        secondCurrencyButton.setTitle(currency, for: .normal)
    }
    
    func didFetchResult(_ result: NSAttributedString) {
        resultLbl.attributedText = result
    }
    
    func didGetError(_ error: String) {
        errorView.errorMessage = error
        errorView.isHidden = false
    }
}
