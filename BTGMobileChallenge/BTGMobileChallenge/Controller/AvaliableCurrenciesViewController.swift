//
//  CurrenciesAvaliableViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

protocol ConversionDelegate {
	func getFromCurrency(selectedCurrencyCode: String)
	func getToCurrency(selectedCurrencyCode: String)
}

enum FillingField {
	case fromCurrency
	case toCurrency
}

class AvaliableCurrenciesViewController: BTGViewController {
	private let viewModel = ConversionViewModel()
	private var currenciesView: AvaliableCurrenciesView { return self.view as! AvaliableCurrenciesView }
	private var avaliableQuotes = [(code: String, description: String)]()
	private var fillingField: FillingField?
	
	var delegate: ConversionDelegate?
	
	init(filling: FillingField) {
		super.init(nibName: nil, bundle: nil)
		self.fillingField = filling
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		navigationController?.navigationBar.prefersLargeTitles = true
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindUI()
	}
	
	override func loadView() {
		self.view = AvaliableCurrenciesView(frame: UIScreen.main.bounds)
		currenciesView.tableViewDelegate = self
		currenciesView.tableViewDataSource = self
	}

	private func bindUI() {
		self.showLoading()
		viewModel.getAvaliableQuotes { [weak self] result in
			guard let self = self else { return }
			self.hideLoading()
			switch result {
			case .success(let avaliableQuotes):
				self.avaliableQuotes = avaliableQuotes
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.currenciesView.reloadTableData()
				}
				
			case .failure(let error):
				print(error)
			}
		}
	}
}

// MARK: TableBiew setup
extension AvaliableCurrenciesViewController: UITableViewDataSource, UITableViewDelegate {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return avaliableQuotes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: AvaliableCurrencyTableViewCell.identifier, for: indexPath) as? AvaliableCurrencyTableViewCell else {
			return UITableViewCell()
		}
		cell.config(code: avaliableQuotes[indexPath.row].code, description: avaliableQuotes[indexPath.row].description)
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		fillingField == .fromCurrency ?
			delegate?.getFromCurrency(selectedCurrencyCode: avaliableQuotes[indexPath.row].code) :
			delegate?.getToCurrency(selectedCurrencyCode: avaliableQuotes[indexPath.row].code)
		
		self.navigationController?.popViewController(animated: true)
	}
}
