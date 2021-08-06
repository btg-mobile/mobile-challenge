//
//  ConversionViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class ConversionViewController: BTGViewController {
	private let showerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 5, green: 0, blue: 200, alpha: 1)
		return  view
	}()
	
	private let fromCurrencyButton: BTGButton = {
		let button = BTGButton()
		button.backgroundColor = .orange

		return button
	}()
	
	private let toCurrencyButton: BTGButton = {
		let button = BTGButton()
		button.backgroundColor = .orange
		
		return button
	}()
	
	private let stackToButtons = UIStackView()
	private let viewModel = ConversionViewModel()
	private var fromCurrencyCode = "USD"
	private var toCurrencyCode: String?
	private var value: Float = 1
	
	var delegate: ConversionDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindUI()
	}
	
	private func setupUI() {
		view.addSubview(showerView)
		view.addSubview(stackToButtons)
		stackToButtons.addArrangedSubview(fromCurrencyButton)
		stackToButtons.addArrangedSubview(toCurrencyButton)
		
		stackToButtons.alignment = .center
		stackToButtons.axis = .horizontal
		stackToButtons.spacing = 10
		stackToButtons.distribution = .fillEqually
		setupConstraints()
	}
	
	private func bindUI() {
		fromCurrencyButton.onClick = {
			let viewController = AvaliableCurrenciesViewController(filling: .fromCurrency)
			viewController.delegate = self
			self.navigationController?.pushViewController(viewController, animated: true)
		}
		
		toCurrencyButton.onClick = {
			let viewController = AvaliableCurrenciesViewController(filling: .toCurrency)
			viewController.delegate = self
			self.navigationController?.pushViewController(viewController, animated: true)
		}
	}
}

// MARK: Layout construction
extension ConversionViewController {
	private func setupConstraints() {
		let bottom: NSLayoutYAxisAnchor
		let top: NSLayoutYAxisAnchor
		if #available(iOS 11.0, *) {
			top = view.safeAreaLayoutGuide.topAnchor
			bottom = view.safeAreaLayoutGuide.bottomAnchor
		} else {
			top = view.topAnchor
			bottom = view.bottomAnchor
		}
		
		showerView.anchor(
			top: (top, 20),
			right: (view.rightAnchor, 20),
			left: (view.leftAnchor, 20),
			bottom: (stackToButtons.topAnchor, 10)
		)
		
		stackToButtons.anchor(
			right: (view.rightAnchor, 20),
			left: (view.leftAnchor, 20),
			bottom: (bottom, 20)
		)
		
		fromCurrencyButton.anchor(height: 100)
		toCurrencyButton.anchor(height: 100)
	}
}

// MARK: Conversion Delegate
extension ConversionViewController: ConversionDelegate {
	func getFromCurrency(selectedCurrencyCode: String) {
		self.fromCurrencyCode = selectedCurrencyCode
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
			viewModel.getQuotationValue(from: fromCurrencyCode, to: toCurrencyCode, quantity: 1) { result in
				self.hideLoading()
				print(result)
			}
		}
	}
}

