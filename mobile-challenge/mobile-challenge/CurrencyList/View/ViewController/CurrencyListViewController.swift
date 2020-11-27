//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    var currencyListView: CurrencyListView {
        return view as! CurrencyListView
    }
    weak var coordinator: CurrencyListCoordinator?
    var manager: CurrencyListManager
    
    init() {
        self.manager = CurrencyListManager()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = CurrencyListView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUpNavigation()
        setUpTableView()
    }
    
    func setUpTableView() {
        currencyListView.tableView.delegate = manager
        currencyListView.tableView.dataSource = manager
        manager.tableView = currencyListView.tableView
    }
    
    func setUpNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: CurrencyListColors.currencyTitle.color]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: CurrencyListColors.currencyTitle.color]
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = CurrencyListStrings.title.text
        
        navigationController?.navigationBar.backgroundColor = AppColors.appBackground.color
        navigationController?.navigationBar.tintColor = CurrencyListColors.currencyTitle.color
    }
}

extension CurrencyListViewController: CurrenciesQuotationDelegate {
    func didFinishFetchQuotations(currenciesQuotation: [CurrencyQuotation]) {
        DispatchQueue.main.async {
            self.manager.currenciesQuotation = currenciesQuotation
            self.manager.tableView?.reloadData()
        }
    }
    
    func didFinishFetchQuotationsWithError(error: Error) {
        let alert = UIAlertController(title: "Ocorreu um Erro", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Continuar", style: .default)
        alert.addAction(action)
        
        self.present(alert, animated: true)
    }
}
