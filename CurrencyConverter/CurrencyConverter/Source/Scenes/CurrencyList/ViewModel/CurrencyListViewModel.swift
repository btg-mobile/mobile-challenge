//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import Foundation

typealias Currency = (code: String, name: String)

protocol CurrencyListViewModeling {
    var delegate: CurrencyListViewModelDelegate? { get set }
    func loadCurrencyList()
    func currienciesCount() -> Int
    func getCurrencyAt(index: Int) -> Currency
    func selectCurrencyAt(index: Int)
}

protocol CurrencyListViewModelDelegate: class {
    func updateUI()
    func presentError()
}

class CurrencyListViewModel: CurrencyListViewModeling {
    
    // MARK: - Properties
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    var selectedCurrency: ((Currency) -> Void)?
    
    private var currencies: [Currency] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.updateUI()
            }
        }
    }
    
    private let provider: Provider
    
    // MARK: - Initializer
    
    init(provider: Provider = URLSessionProvider()) {
        self.provider = provider
    }
    
    // MARK: - Logic Functions
    
    func loadCurrencyList() {
        provider.request(type: CurrencyLayerListResponse.self, service: CurrencyLayerService.list) { [weak self] (result) in
            switch result {
            case .success(let response):
                self?.currencies = response.currencies.map({ ($0.key, $0.value) })
            case .failure(_):
                self?.presentError(message: "")
            }
        }
    }
    
    private func presentError(message: String) {
        DispatchQueue.main.async {
            self.delegate?.presentError()
        }
    }
    
    // MARK: - Protocol functions
    
    func currienciesCount() -> Int {
        return currencies.count
    }
    
    func getCurrencyAt(index: Int) -> Currency {
        return currencies[index]
    }
    
    func selectCurrencyAt(index: Int) {
        let currency = getCurrencyAt(index: index)
        print(currency)
        selectedCurrency?(currency)
    }
    
}
