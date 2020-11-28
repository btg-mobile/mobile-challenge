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
    var tagButton: TagButton
    var viewModel: CurrencyListViewModel
    
    init() {
        self.manager = CurrencyListManager()
        self.tagButton = .origin
        self.viewModel = CurrencyListViewModel()
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
        setUpClosures()
        setUpNavigation()
        setUpTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        coordinator?.didFinish()
    }
    
    func setUpTableView() {
        currencyListView.tableView.delegate = manager
        currencyListView.tableView.dataSource = manager
        manager.tableView = currencyListView.tableView
    }
    
    func setUpNavigation(){
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: CurrencyListColors.currencyTitle.color ?? .blue]
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: CurrencyListColors.currencyTitle.color ?? .blue]
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = CurrencyListStrings.title.text
        
        navigationController?.navigationBar.backgroundColor = AppColors.appBackground.color
        navigationController?.navigationBar.tintColor = CurrencyListColors.currencyTitle.color
    }
}

private extension CurrencyListViewController {
    func setUpClosures() {
        self.manager.selectedCurrency = { currencyQuotation in
            self.coordinator?.didFinish(currencyQuotation: currencyQuotation, tagButton: self.tagButton)
        }
    }
}

extension CurrencyListViewController: CurrenciesQuotationDelegate {
    func didFinishFetchQuotations(currenciesQuotation: [CurrencyQuotation], tagButton: TagButton) {
        self.tagButton = tagButton
        let sortedCurrencies = self.viewModel.sortArray(by: .code, currenciesQuotation: currenciesQuotation)
        
        self.manager.currenciesQuotation = sortedCurrencies
            
        DispatchQueue.main.async {
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
