//
//  CurrencysViewController.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencysViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var segmentControll: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Attributes
    private let viewModel: CurrencysViewModel
    private var selectedCurrency: (Currency) -> Void = { _ in }

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupNavigationBar()
    }

    // MARK: Initializers
    init(currencysViewModel: CurrencysViewModel) {
        self.viewModel = currencysViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods
    private func setupTableView() {
        let nib = UINib(nibName: "CurrencyTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    private func setupNavigationBar() {
        let backButton = UIBarButtonItem()
        backButton.title = StringsDictionary.back
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

    // MARK: - Public Methods
    func setDelegate(selectedCurrency: @escaping (Currency) -> Void) {
        self.selectedCurrency = selectedCurrency
    }

    // MARK: - Actions
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - TableViewDelegate
extension CurrencysViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let currency = self.viewModel.getCurrency(position: indexPath.row) {
            self.selectedCurrency(currency)
            self.viewModel.dismiss()
        }
    }
}

// MARK: - TableViewDataSource
extension CurrencysViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.getCurrencys().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: CurrencyTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.reuseIdentifier, for: indexPath) as? CurrencyTableViewCell {
            if let currency = self.viewModel.getCurrency(position: indexPath.row) {
                cell.setupCell(currency: currency)
                return cell
            }
        }
        return UITableViewCell()
    }
}
