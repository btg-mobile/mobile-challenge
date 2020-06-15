//
//  CurrencyListViewController.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 11/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewData: [CurrencyListViewData] = []
    var viewModel: CurrencyListViewModelContract!
    
    init (with viewModel: CurrencyListViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: "CurrencyListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerNib()
        self.sheetViewController?.resize(to: .fixed(300))
        self.fetch()
    }
    
    func fetch () {
        self.viewModel.fetch { result in
            switch result {
            case .success(let data):
                self.viewData = data
                self.setupUI()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func setupUI() {
        self.tableView.reloadData()
        self.sheetViewController?.resize(to: .fullScreen)
    }
    
    private func registerNib() {
        tableView.registerNibForTableViewCell(CurrencyListCell.self)
    }
    
}
extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListCell.reusableIdentifier, for: indexPath) as? CurrencyListCell else {
            return UITableViewCell()
        }
        cell.setLabels(data: viewData[indexPath.row])
        return cell
    }
}
