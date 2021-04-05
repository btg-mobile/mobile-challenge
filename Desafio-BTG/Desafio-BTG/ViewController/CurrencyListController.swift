//
//  CurrencyListController.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

class CurrencyListController: BaseViewController, DismissScreen {
    
    // MARK: - Properties
    
    var viewModel: CurrencyViewModel?
    lazy var mainView = CurrencyListView(viewModel: viewModel)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigation()
        fetchValue()
        fetchDetails()
        mainView.delegate = self
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    // MARK: - Private functions
    
    private func fetchValue() {
        self.viewModel?.fetchCurrentValue { [weak self] success in
            guard let self = self else { return }
            if success {
                self.mainView.tableView.reloadData()
            } else {
                self.handleError()
            }
        }
    }
    
    private func fetchDetails() {
        self.viewModel?.fetchDetails { [weak self] success in
            guard let self = self else { return }
            if success {
                self.mainView.tableView.reloadData()
            } else {
                self.handleError()
            }
        }
    }
    
    private func handleError() {
        self.showAlert(alertText: "Error", alertMessage: "Error")
    }
    
    func dismissScreenTapped() {
        dismiss(animated: true, completion: nil)
    }
}
