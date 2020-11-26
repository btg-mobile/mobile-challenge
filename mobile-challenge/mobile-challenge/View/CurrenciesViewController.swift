//
//  CurrenciesViewController.swift
//  mobile-challenge
//
//  Created by Fernanda Sudré on 24/11/20.
//

import UIKit

class CurrenciesViewController: UIViewController {

    ///Constant of the link that gets the requests
    let url = "http://api.currencylayer.com/list?access_key=baa8ca67a82137316bb59b665428e101"
    
    ///Dictionary that will --guardar--- the values of the currencies fetched from API
    var quotes: Dictionary<String, String> = [:]
    var acronyms: [String] = []
    var currencyNames: [String] = []
    var count = 0
    var selected = " "
    var passCurrency: PassCurrencyDelegate?
    @IBOutlet weak var currencyTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var indexPath = 0
    
    //Instance of view controller to change the title of the button
    var viewControllerInstance = ViewController()
    //Flag to verify which button is the sender
    var flag = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        count = acronyms.count
    
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        self.selected = acronyms[indexPath]
        if flag == 1{
            self.passCurrency?.passCurrency(currency: selected,flag: 1)
        }else if flag == 2{
            self.passCurrency?.passCurrency(currency: selected,flag: 2)
            
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell") as! CurrencyCell
        cell.currencyLabel.text =
            self.acronyms[indexPath.row] + " - " + self.currencyNames[indexPath.row]
        if cell.isSelected{
            currencyTableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
            self.selected = self.acronyms[indexPath.row]
            self.indexPath = indexPath.row
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.indexPath = indexPath.row
    }
    
}


