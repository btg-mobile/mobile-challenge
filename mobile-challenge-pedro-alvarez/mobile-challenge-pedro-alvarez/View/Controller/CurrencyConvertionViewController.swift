//
//  CurrencyConvertionViewController.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

enum CurrencyConvertionButtonIdentifier {
    case first
    case second
}

class CurrencyConvertionViewController: UIViewController {
    
    private lazy var firstCurrencyButton: CurrencyButton = {
        return CurrencyButton(frame: .zero, title: .empty)
    }()
    
    private lazy var secondCurrencyButton: CurrencyButton = {
        return CurrencyButton(frame: .zero, title: .empty)
    }()
    
    private lazy var convertActionButton: ConvertActionButton = {
        return ConvertActionButton(frame: .zero)
    }()
    
    private lazy var resultLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var mainView: CurrencyConvertionView = {
        return CurrencyConvertionView(firstCurrencyButton: firstCurrencyButton,
                                      secondCurrencyButton: secondCurrencyButton,
                                      convertActionButton: convertActionButton,
                                      resultLbl: resultLbl)
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
        tabBarItem = UITabBarItem(title: "Converter", image: nil, tag: 1)
        self.viewModel = CurrencyConvertionViewModel(delegate: self)
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
        
    }
}
