//
//  CurrencyListViewModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

protocol CurrencyListViewModelProtocol {
    var currencyList: [CurrencyListModel] { get }
    var delegate: CurrencyListViewModelDelegate? { get set }
    
    func fetchCurrencies()
    func didSelectCurrency(id: String)
}

protocol CurrencyListViewModelDelegate: class {
    func didFetchSelectedCurrency(id: String)
    func didFetchCurrencies()
    func didGetError(_ error: String)
}

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    private(set) var currencyList: [CurrencyListModel] = [] {
        didSet {
            delegate?.didFetchCurrencies()
        }
    }
    
    private(set) var selectedCurrencyId: String? {
        didSet {
            guard let id = selectedCurrencyId else { return }
            delegate?.didFetchSelectedCurrency(id: id)
        }
    }
    
    private(set) var provider: CurrencyListProviderProtocol
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    init(provider: CurrencyListProviderProtocol = CurrencyListProvider(),
         delegate: CurrencyListViewModelDelegate? = nil) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func fetchCurrencies() {
        provider.fetchList { response in
            switch response {
            case .success(let model):
                self.currencyList = CurrencyListModel.getCurrencyList(fromJson: model.currencies)
                break
            case .error(let error):
                self.delegate?.didGetError(error.localizedDescription)
                break
            case .genericError:
                self.delegate?.didGetError(Constants.Errors.genericError)
                break
            }
        }
    }
    
    func didSelectCurrency(id: String) {
        delegate?.didFetchSelectedCurrency(id: id)
    }
}
