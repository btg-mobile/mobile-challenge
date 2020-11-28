//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import UIKit

class QuotationViewController: UIViewController {
    
    weak var coordinator: QuotationCoordinator?
    private var viewModel: QuotationViewModel
    
    var originCurrencyQuotation: CurrencyQuotation?
    var destinyCurrencyQuotation: CurrencyQuotation?
    
    var quotationView: QuotationView {
        return view as! QuotationView
    }
    
    init(viewModel: QuotationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = QuotationView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        quotationView.chooseCurrencyView.originCurrencyButton.addTarget(self, action: #selector(makeRequest(sender:)), for: .touchUpInside)
        quotationView.chooseCurrencyView.destinyCurrencyButton.addTarget(self, action: #selector(makeRequest(sender:)), for: .touchUpInside)
        quotationView.convertButton.addTarget(self, action: #selector(convert), for: .touchUpInside)
    }
    
    @objc func makeRequest(sender: UIButton){
        switch sender.tag {
        case TagButton.origin.rawValue:
            getCurrenciesQuotation(tagButton: TagButton.origin)
        default:
            getCurrenciesQuotation(tagButton: TagButton.destiny)
        }
        
    }
    
    @objc func convert() {
        guard let valueStr = quotationView.chooseCurrencyView.textValueToConvert.text else { return }
        guard let origin = originCurrencyQuotation else { return }
        guard let destiny = destinyCurrencyQuotation else { return }
        let value = Double(valueStr) ?? 0.0
        
        let convertedValue = viewModel.convert(value: value, origin: origin, destiny: destiny)
        
        quotationView.chooseCurrencyView.resultLabel.text = convertedValue
    }
    
    func getCurrenciesQuotation(tagButton: TagButton) {
        coordinator?.showCurrencyList()
        viewModel.getCurrenciesQuotation { (result) in
            switch result {
            case .success(let currenciesQuotation):
                self.coordinator?.currencyList?.didFinishFetchQuotations(currenciesQuotation: currenciesQuotation, tagButton: tagButton)
            case .failure(let error):
                self.coordinator?.currencyList?.didFinishFetchQuotationsWithError(error: error)
            }
        }
    }
}

extension QuotationViewController {
    func updateUI(currencyQuotation: CurrencyQuotation, tagButton: TagButton) {
        if tagButton == .origin {
            self.quotationView.chooseCurrencyView.originCurrencyButton.setTitle(currencyQuotation.code, for: .normal)
            self.originCurrencyQuotation = currencyQuotation
        } else {
            quotationView.chooseCurrencyView.destinyCurrencyButton.setTitle(currencyQuotation.code, for: .normal)
            self.destinyCurrencyQuotation = currencyQuotation
        }
    }
}

