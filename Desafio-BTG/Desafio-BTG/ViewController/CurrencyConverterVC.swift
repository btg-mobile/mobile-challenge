//
//  CurrencyConverterVC.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import UIKit

class CurrencyConverterVC: BaseViewController {

//    var viewModel: CurrencyViewModel
    private var viewModelList = CurrencyViewModel()
    
    private lazy var contentView: CurrencyConverterView = {
        let view = CurrencyConverterView(viewModel: viewModelList)
        view.firstCountyAction = countryFirstPressed
        view.secondCountryAction = countrySecondPressed
        view.handleConvertAction = handleConvertPressed
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        self.view.backgroundColor = .white
    }
    
    
    init(viewModel: CurrencyViewModel) {
        self.viewModelList = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupCountryUI()
        setupCountryTwoUI()
    }
    
    func setupCountryUI() {
        guard let setupCountryName = viewModelList.countrySelectedOne else { return }
        contentView.currentCurrencyBt.setTitle("\(setupCountryName)", for: .normal)
    }
    
    func setupCountryTwoUI() {
      guard let setupCountryNameTo = viewModelList.countrySelectedTwo else { return }
        contentView.destinationCountryBt.setTitle("\(setupCountryNameTo)", for: .normal)
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    /// go to user registration
    private func countryFirstPressed() {
        let goToTableView = CurrencyListController(viewModel: viewModelList)
        let navVC = UINavigationController(rootViewController: goToTableView)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        SelectedCurrencySingleton.selectedCurrency = .ofCurrency
    }
    
    private func countrySecondPressed() {
        let goToTableView = CurrencyListController(viewModel: viewModelList)
        let navVC = UINavigationController(rootViewController: goToTableView)
        navVC.modalPresentationStyle = .fullScreen
        present(navVC, animated: true, completion: nil)
        SelectedCurrencySingleton.selectedCurrency = .toCurrency
    }
    
    private func allowConvert() -> Bool {
        if contentView.currentCurrencyBt.titleLabel?.text == "select country" || contentView.destinationCountryBt.titleLabel?.text == "select country" {
            return false
        }
        return true
    }
    
    private func handleConvertPressed() {
        if allowConvert() {
            guard let countryOne = viewModelList.countrySelectedOne else { return }
            guard let CountryTwo = viewModelList.countrySelectedTwo else { return }
            guard let convertedValue = contentView.insertTextField.text else { return}
            
            viewModelList.loadCurrencyData(ofCurrency: countryOne, toCurrency: CountryTwo, value: Double(convertedValue) ?? 0.0) {  [weak self] (finalValue) in
                guard let self = self else { return }
                
                let stringFormatted = String(format: "%.2f", finalValue ?? 0.0)
                self.contentView.valueConverttedTextField.text = String(stringFormatted)
            }
        } else {
            showAlert(alertText: "Error", alertMessage: "please select a country")
        }
    }
}

