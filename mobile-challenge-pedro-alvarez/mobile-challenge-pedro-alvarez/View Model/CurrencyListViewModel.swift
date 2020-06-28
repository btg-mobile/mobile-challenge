//
//  CurrencyListViewModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol CurrencyListViewModelProtocol {
    var delegate: CurrencyListViewModelDelegate? { get set }
    var currenciesViewModel: [NSAttributedString] { get  }
    
    func fetchCurrencies()
    func didSelectCurrency(index: Int)
}

protocol CurrencyListViewModelDelegate: class {
    func didFetchSelectedCurrency(id: String)
    func didFetchCurrencies()
    func didGetError(_ error: String)
}

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    private var currencyList: [CurrencyListModel] = [] {
        didSet {
            currencyList.sort(by: { $0.id < $1.id })
            currenciesViewModel = convertCurrencyViewModel(currencyList)
        }
    }
    
    private(set) var selectedCurrencyId: String? {
        didSet {
            guard let id = selectedCurrencyId else { return }
            delegate?.didFetchSelectedCurrency(id: id)
        }
    }
    
    private(set) var currenciesViewModel: [NSAttributedString] = [] {
        didSet {
            delegate?.didFetchCurrencies()
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
    
    func didSelectCurrency(index: Int) {
        let id = currencyList[index].id
        delegate?.didFetchSelectedCurrency(id: id)
    }
}

extension CurrencyListViewModel {
    
    private func convertCurrencyViewModel(_ currencies: [CurrencyListModel]) -> [NSAttributedString] {
        var attributesStrings: [NSAttributedString] = []
        for currency in currencies {
            attributesStrings.append(NSAttributedString(string: currency.id + .space + currency.fullName,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.currencyLblColor, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15)]))
        }
        return attributesStrings
    }
}
