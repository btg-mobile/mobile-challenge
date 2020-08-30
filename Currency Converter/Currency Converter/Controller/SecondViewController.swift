//
//  SecondViewController.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var currencies = [Currency]()
    var currencyPosition = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        Currency.listCurrencies { (receivedCurrencies, error) in
            
            if (error != nil) {
                
                // Handle error
            }
            
            let realm = try! Realm()
            
            let currencyList = realm.objects(Currency.self).filter("active = true").sorted(byKeyPath: "shortName")
            
            self.currencies.removeAll()
            self.currencies.append(contentsOf: currencyList)
            
            self.tableView.reloadData()
        }
    }
}

// MARK: - Extension
extension SecondViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell
        let currency = self.currencies[indexPath.row]
        
        cell.shortName.text = currency.shortName
        cell.longName.text = currency.longName

        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        let user = User.getMainUser()
        if let user = user {
            user.changeCurrency(currencyPosition, currency.shortName!)
        }
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
        }
    }
}
