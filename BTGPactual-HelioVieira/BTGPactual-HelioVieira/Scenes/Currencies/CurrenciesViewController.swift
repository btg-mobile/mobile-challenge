//
//  CurrenciesViewController.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 10/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

final class CurrenciesViewController: UIViewController {
    
    // MARK: Properties
    private var mode: CurrencyMode!
    private var currencies: [Currency]!
    enum CurrencyMode {
        case input
        case output
    }
    var didSelectCurrency: ((Currency) -> ())?
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            tableView.register(UINib(nibName: CurrencyNameCell.identifier, bundle: nil), forCellReuseIdentifier: CurrencyNameCell.identifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    // MARK: Builder
    class func builder(mode: CurrenciesViewController.CurrencyMode, currencies: [Currency]) -> CurrenciesViewController {
        let viewController = CurrenciesViewController().instantiate() as! CurrenciesViewController
        viewController.mode = mode
        viewController.currencies = currencies
        return viewController
    }
    
    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = mode == .input ? "Currency Input" : "Currency Output"
    }
}

// MARK: Extensions
extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyNameCell.identifier) as? CurrencyNameCell else {return UITableViewCell()}
        
        let currency = currencies[indexPath.row]
        cell.setup(with: currency)
        return cell
    }
}

extension CurrenciesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        self.didSelectCurrency?(currency)
        self.navigationController?.popViewController(animated: true)
    }
}
