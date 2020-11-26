//
//  CurrencyViewController.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

protocol CurrencyViewControllerDelegate:class {
    /**
     Notify what the currency that choose in tableView
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter nameCurrency:String
     - Parameter quote:Double
     - Parameter destiny:CurrencyViewModelDestiny
     */
    func notifyChooseCurrencyConvertVC(nameCurrency:String,quote:Double,destiny:CurrencyViewModelDestiny)
}

class CurrencyViewController: UIViewController {
    
    ///delegateSendData
    weak var delegateSendData:CurrencyViewControllerDelegate?
    
    ///Coordinator
    weak var coordinator:MainCoordinator?
    
    ///Base View
    let baseView = CurrencyView()
    
    ///View Model
    let viewModel = CurrencyViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
        viewModel.delegateChosseCurrency = self
        viewModel.delegateEndRequest = self
    }

    override func viewWillAppear(_ animated: Bool) {
        do {
            try viewModel.configureAllCurrencies()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.tableView.delegate = self
        baseView.tableView.dataSource = self
        
//        setupSearchController()
    }


}

//MARK: - UISearchResultsUpdating
extension CurrencyViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    func setupSearchController() {
        baseView.searchController.searchResultsUpdater = self
        baseView.searchController.obscuresBackgroundDuringPresentation = false
        baseView.searchController.searchBar.placeholder = "Sigla - USD"
        baseView.tableView.tableHeaderView = baseView.searchController.searchBar
//        navigationItem.searchController = baseView.searchController
//        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
}

//MARK: - UITableViewDelegate, - UITableViewDataSource
extension CurrencyViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allCurrenciesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as? CurrencyTableViewCell else{return UITableViewCell()}
        
        viewModel.configureCurrencyName(cell,indexPath.row)
        
        cell.backgroundColor = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! CurrencyTableViewCell
        
        viewModel.delegateChosseCurrency?.notifyChooseCurrency(nameCurrency: cell.nameCurrency, quote: cell.quote,destiny: viewModel.myDestinyData)
        
    }
}

//MARK: - CurrencyViewModelDelegateChooseCurrency
extension CurrencyViewController:CurrencyViewModelDelegateChooseCurrency{
    func notifyChooseCurrency(nameCurrency: String, quote: Double, destiny: CurrencyViewModelDestiny) {
        delegateSendData?.notifyChooseCurrencyConvertVC(nameCurrency: nameCurrency, quote: quote, destiny: destiny)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: - CurrencyViewModelDelegateEndRequest
extension CurrencyViewController:CurrencyViewModelDelegateEndRequest{
    func notifyEndRequestForTableView() {
        baseView.tableView.reloadData()
    }
}
