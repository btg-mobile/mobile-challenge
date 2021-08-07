//
//  ConversionViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class ConversionViewController: BTGViewController {
	
	private let viewModel = ConversionViewModel()
	private var conversionView: ConversionView { return self.view as! ConversionView }
	private var fromCurrencyCode = "USD"
	private var toCurrencyCode: String?
	private var quantity: Float = 1
	
	var delegate: ConversionDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
		bindUI()
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	override func loadView() {
		self.view = ConversionView(frame: UIScreen.main.bounds)
	}
	
	override var preferredStatusBarStyle : UIStatusBarStyle {
		return .lightContent
	}
	
	private func bindUI() {
		conversionView.showFromCurrencyView(code: fromCurrencyCode, value: self.quantity)
		conversionView.fromOnClick = {
			let viewController = AvaliableCurrenciesViewController(filling: .fromCurrency)
			viewController.delegate = self
			self.navigationController?.pushViewController(viewController, animated: true)
		}
		
		conversionView.toOnClick = {
			let viewController = AvaliableCurrenciesViewController(filling: .toCurrency)
			viewController.delegate = self
			self.navigationController?.pushViewController(viewController, animated: true)
		}
	}
}


// MARK: Conversion Delegate
extension ConversionViewController: ConversionDelegate {
	func getFromCurrency(selectedCurrencyCode: String) {
		self.fromCurrencyCode = selectedCurrencyCode
		conversionView.showFromCurrencyView(code: fromCurrencyCode, value: self.quantity)
		self.getQuote()
	}
	
	func getToCurrency(selectedCurrencyCode: String) {
		self.toCurrencyCode = selectedCurrencyCode
		self.getQuote()
	}
}

// MARK: Convertion API Call
extension ConversionViewController {
	func getQuote() {
		if let toCurrencyCode = toCurrencyCode {
			self.showLoading()
			viewModel.getQuotationValue(from: fromCurrencyCode, to: toCurrencyCode, quantity: quantity) { [weak self] result in
				guard let self = self else { return }
				self.hideLoading()
				switch result {
				case .success(let value):
					self.conversionView.showToCurrencyView(code: toCurrencyCode, value: value * self.quantity)
				case .failure(let error):
					debugPrint(error)
				}
			}
		}
	}
}

