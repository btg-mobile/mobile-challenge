//
//  ListViewController.swift
//  Desafio_BTG
//
//  Created by Kleyson on 10/12/2020.
//  Copyright © 2020 Kleyson. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var currencyArray: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.title = "Listagem"
        fetchList()
    }
    
    private func fetchList() {
        API.fetchList { (list) in
            self.currencyArray =  list.currencies ?? [:]
            self.tableView.reloadData()        
        }
    }
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCurrency", for: indexPath)
        let key = Array(currencyArray.keys)[indexPath.row]
        let value = Array(currencyArray.values)[indexPath.row]
        cell.textLabel?.text = key + " - " + value
        return cell
    }
}
