//
//  CurrencyListViewController.swift
//  BTG
//
//  Created by Renato Kuroe on 10/09/20.
//  Copyright © 2020 Renato Kuroe. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableViewCurrencyList: UITableView!
    @IBOutlet weak var spin: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var mainViewController = ViewController()
    var isOrigin = Bool()
    private let cellReuseIdentifier = "cell"
    private var currencies = [Struct.Currency]()
    private var filteredCurrencies = [Struct.Currency]()
    private var isSearching:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Escolha a moeda";
        
        searchBar.delegate = self

        // Register cell
        self.tableViewCurrencyList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        tableViewCurrencyList.delegate = self
        tableViewCurrencyList.dataSource = self
        
        // Remove the extra empty cell divider lines
        self.tableViewCurrencyList.tableFooterView = UIView()
        
        getList()
    }
    
    func getList() {
        
        guard let loanUrl = URL(string: Api.URL_LIST) else {
            return
        }
        
        let request = URLRequest(url: loanUrl)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            
            if ((error) != nil) {

                OperationQueue.main.addOperation({
                    self.currencies = Utils.getCurrencyList() ?? [Struct.Currency]()
                    
                    if self.currencies.count == 0 {
                        // Happens when first launch app with no internet connection.
                        Utils.showAlert(vc: self, message: "Impossível obter dados sem conexão com a internet/")
                    }
                    
                    Utils.showAlert(vc: self, message: "Você parece estar sem conexão com a internet. Dados gerados anteriormente serão utilizados e poderão estar desatualizados.")
                    self.tableViewCurrencyList.reloadData()
                    self.tableViewCurrencyList.isHidden = false;
                    self.spin.stopAnimating()
                })
                
                return
            }
            // Parse JSON data
            if let data = data {
                self.parseJsonData(data: data)
                // Reload table view
                OperationQueue.main.addOperation({
                    self.tableViewCurrencyList.reloadData()
                    self.tableViewCurrencyList.isHidden = false;
                    self.spin.stopAnimating()
                })
            }
        })
        
        task.resume()
    }
    
    func parseJsonData(data: Data){
        
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            let jsonCurrencies = jsonResult?["currencies"] as! Dictionary<String, String>
            for (key, value) in jsonCurrencies {
                let currency = Struct.Currency(code: key, name: value)
                self.currencies.append(currency)
            }
            
            self.currencies =  self.currencies.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
            
            // Save List for persistent data
            Utils.saveCurrencyListData(data: data)
            
        } catch {
            Utils.showAlert(vc: self, message: error.localizedDescription)
        }
        
    }
    
    //MARK: - Table View Delegates
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.filteredCurrencies.count;
        }
        return self.currencies.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create a new cell if needed or reuse an old one
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellReuseIdentifier)
        
        // set the text from the data model
        let currency: Struct.Currency;
        
        if isSearching {
            currency = self.filteredCurrencies[indexPath.row]
        } else {
            currency = self.currencies[indexPath.row]
        }
            
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.code
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            
            let currency: Struct.Currency;
            if self.isSearching {
                currency = self.filteredCurrencies[indexPath.row]
            } else {
                currency = self.currencies[indexPath.row]
            }
            
            if self.isOrigin {
                self.mainViewController.setOriginCurrency(currency: currency)
            } else {
                self.mainViewController.setDestinyCurrency(currency: currency)
            }
        }
    }
    
    //MARK: - Search Bar Delegates

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
        } else {
            filteredCurrencies = currencies.filter { result in
                return result.name.contains(searchText) ||
                    result.code.contains(searchText)
            }
            isSearching = true
        }
        self.tableViewCurrencyList.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    // MARK: - Segment Control Action
    
    @IBAction func actionSegmentValueChanged(_ sender: Any) {
        switch (sender as! UISegmentedControl).selectedSegmentIndex
        {
        case 0:
            self.currencies =  self.currencies.sorted(by: { $0.name.lowercased() < $1.name.lowercased() })
        case 1:
            self.currencies =  self.currencies.sorted(by: { $0.code.lowercased() < $1.code.lowercased() })
        default:
            break
        }
        self.tableViewCurrencyList.reloadData()
    }
}
