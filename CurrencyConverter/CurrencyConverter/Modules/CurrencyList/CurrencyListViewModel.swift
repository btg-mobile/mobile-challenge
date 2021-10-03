//
//  CurrencyListViewModel.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 30/09/21.
//

import UIKit

protocol CurrencyListViewModelDelegate: AnyObject {
    func didReloadData()
    func failedToGetCurrencyList()
}

final class CurrencyListViewModel {
    
    weak var delegate: CurrencyListViewModelDelegate?
    var searchController: UISearchController!
    var models = [String]()
    var filteredData: [String]?
    var filteredKey = [String]()
    
    init(delegate: CurrencyListViewModelDelegate) {
        self.delegate = delegate
        fetchCurrencyList()
    }
    
    private func loadData(with model: Currency){
        filteredKey.removeAll()
        model.currencies.forEach{ currency in
            models.append("\(currency.key): \(currency.value)")
            filteredKey.append("\(currency.key)")
        }
        filteredData = models
        delegate?.didReloadData()
    }
    
    private func fetchCurrencyList(){
        APICaller.shared.getCurrencies{ [weak self] result in
            DispatchQueue.main.async{
                switch result {
                case .success(let model):
                    self?.loadData(with: model)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.delegate?.failedToGetCurrencyList()
                }
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filteredData = searchText.isEmpty ? models : models.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil})
            filteredKey = searchText.isEmpty ? filteredKey : models.filter({(dataString: String) -> Bool in
                return dataString.range(of: searchText, options: .caseInsensitive) != nil})
            delegate?.didReloadData()
        }
    }
    
    func getNumberOfRows() -> Int {
        guard let count = filteredData?.count else {
            return 0
        }
        return count
    }
    
}
