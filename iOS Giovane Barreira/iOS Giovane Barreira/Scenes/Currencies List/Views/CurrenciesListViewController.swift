//
//  CurrenciesListViewController.swift
//  iOS Giovane Barreira
//
//  Created by Giovane Barreira on 10/4/20.
//

import UIKit

class CurrenciesListViewController: UIViewController {

    @IBOutlet weak var listTableview: UITableView!

    private let identifier = "cell"
    var currenciesListViewModel = CurrenciesListViewModel()
    var currenciesModel = CurrenciesListModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Currencies List"
        setupTableViewCell()
        currenciesListViewModel.fetchList()
        currenciesListViewModel.currenciesListViewModelProtocolDelegate = self
    }
    
    func setupTableViewCell() {
        listTableview.dataSource = self
        listTableview.delegate = self
        
        listTableview.register(UINib(nibName: "CurrenciesListCellTableViewCell", bundle: nil), forCellReuseIdentifier: identifier)

        if let navigationController = self.navigationController {
            navigationController.navigationBar.prefersLargeTitles = true
        }
    }
}

extension CurrenciesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesModel.currencies?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = listTableview.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CurrenciesListCellTableViewCell else {
            fatalError("Could not find \(identifier)")
        }

        let bindData = CurrenciesListBind(currenciesModel)
    
    
        cell.cellTitleLbl.text = bindData.title?[indexPath.row]
        cell.cellSubtitleLbl.text = bindData.description?[indexPath.row]
        
        return cell
    }
}

extension CurrenciesListViewController: CurrenciesListViewModelOutputProtocol {
    func getList(listModel: CurrenciesListModel) {
        currenciesModel = listModel
        
        DispatchQueue.main.async {
            self.listTableview.reloadData()
        }
    }
}
