//
//  BTGCurrenciesAvaliableViewController.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation
import UIKit


class BTGCurrenciesAvaliableViewController: BTGBaseViewController<BTGCurrenciesAvaliableView> {
    
    let viewModel: BTGCurrenciesAvaliableViewModel
    
    init(viewModel: BTGCurrenciesAvaliableViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addTargets()
        bindViewModel()
        
        viewModel.fetchCurrenciesAvaliable()
    }
}


fileprivate extension BTGCurrenciesAvaliableViewController {
    func setupView() {
        mainView.setupTableView(delegate: self, dataSource: self)
    }
    
    func addTargets() {
        mainView.searchBar.delegate = self
    }
}

extension BTGCurrenciesAvaliableViewController {
    func bindViewModel() {
        viewModel.didUpdateList = { [unowned self] in
            self.mainView.tableView.reloadData()
        }
        viewModel.didShowError = {  [unowned self] error in
            self.showAlert("Ops", error)
        }
    }
}

extension BTGCurrenciesAvaliableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        viewModel.filterCurrencies(textSearched: textSearched)
    }
}


//Tableview
extension BTGCurrenciesAvaliableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectCurrency(at: indexPath.row)
    }
}

extension BTGCurrenciesAvaliableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberCurrenciesToShow())
        return viewModel.numberCurrenciesToShow()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? BTGCurrencyCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.update(currency: viewModel.currenciesToShow[indexPath.row])
        
        return cell
    }
}
