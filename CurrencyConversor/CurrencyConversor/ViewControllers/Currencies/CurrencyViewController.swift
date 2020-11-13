//
//  CurrencyViewController.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 05/11/20.
//

import UIKit

class CurrencyViewController: UIViewController {
    
    private var currenciesListItems: [CountryResponse] = []
    var delegate: SelectedCellDelegate?
    
    // MARK: Properties
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var availableCurrenciesLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAvailableCurrencies()
    }
    
    // MARK: Setup Methods
    private func setupTexts() {
        cancelButton.setTitle(StringIdentifier.cancel.getString(), for: .normal)
        availableCurrenciesLabel.text = StringIdentifier.availableCurrencies.getString()
    }
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: CurrenciesTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: Functions
    private func loadAvailableCurrencies() {
        CurrentListRequest.sharedInstance.getAllCurrencies(
            success: { [weak self] response in
                guard let `self` = self else { return }
                DispatchQueue.main.async {
                    self.currenciesListItems = (response?.currencies?.compactMap({
                        CountryResponse(
                            code: $0.0,
                            name: $0.1)
                    })
                    .sorted() {
                        $0.name < $1.name
                    })!
                    
                    self.tableView.reloadData()
                }
            },
            failure: { [weak self] error in
                guard let `self` = self else { return }
                if let error = error {
                    debugPrint(error.info)
                }
            })
    }
    
    // MARK: Actions
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension CurrencyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currenciesListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrenciesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let item = currenciesListItems[indexPath.row]
        cell.setup(code: item.code, name: item.name)
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension CurrencyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let _: CurrenciesTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let item = currenciesListItems[indexPath.row]
        delegate?.selectedCell(item.code)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

