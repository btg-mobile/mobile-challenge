//
//  CurrencyViewController.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

protocol CurrencyViewControllerDelegate:class {
    func notifyChooseCurrencyConvertVC(nameCurrency:String,quote:Double,destiny:CurrencyViewModelDestiny)
}

class CurrencyViewController: UIViewController {
    
    weak var delegate:CurrencyViewControllerDelegate?
    
    weak var coordinator:MainCoordinator?
    
    let baseView = CurrencyView()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
        baseView.viewModel.delegate1 = self
        baseView.viewModel.delegate2 = self
    }

    override func viewWillAppear(_ animated: Bool) {
        do {
            try baseView.viewModel.configureAllCurrencies()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }

}

extension CurrencyViewController:CurrencyViewModelDelegate{
    func notifyChooseCurrency(nameCurrency: String, quote: Double, destiny: CurrencyViewModelDestiny) {
        delegate?.notifyChooseCurrencyConvertVC(nameCurrency: nameCurrency, quote: quote, destiny: destiny)
        self.dismiss(animated: true, completion: nil)
    }
}

extension CurrencyViewController:CurrencyViewModelDelegateEndRequest{
    func notifyEndRequestForTableView() {
        baseView.tableView.reloadData()
    }
}
