//
//  CurrencyListViewController.swift
//  Mobile Challenge
//
//  Created by Vinicius Serpa on 16/11/24.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    let currencyVM: CurrencyViewModel = CurrencyViewModel()
    let conversionVM: ConversionViewModel = ConversionViewModel()
    var onCurrencySelected: ((String, Float) -> Void)?
    
    var isPrimarySelection: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: ListView Configuration
    func setupTableView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    //MARK: UI Configuration Function
    func setupUI() {
        setupTableView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        
        currencyVM.pullCurrencyNames { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            self?.conversionVM.fetchConvertions()
        }
    }
    
    //MARK: TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyVM.currencyNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let currency = currencyVM.currencyNames[indexPath.row]
        cell.textLabel?.text = "\(currency.code) - \(currency.name)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCurrencyCode = conversionVM.convertions[indexPath.row].code
        let selectedCurrencyValue = conversionVM.convertions[indexPath.row].dolarValue
        onCurrencySelected?(selectedCurrencyCode, selectedCurrencyValue)
        navigationController?.popViewController(animated: true)
    }
    
}
