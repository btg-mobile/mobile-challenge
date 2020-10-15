//
//  InitialViewController.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 06/10/20.
//

import UIKit

// MARK: Inicialization
final class InitialViewController: UIViewController {
	
	@TemplateView private var inputedMoney: CurrencyTextField
	
	@TemplateView private var  outputedMoney: UILabel
	
	@TemplateView private var inputedCurrency: UIButton
	
	@TemplateView private var  outputedCurrency: UIButton
	
	
	private let viewModel: InitialViewModel
	
	
	init(viewModel: InitialViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Currency conversion"
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = UIColor.App.initialBackground
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
		
		addViews()
		addContraintsToTextField()
		addConstraintsToLabel()
		addContraintsToButtons()
		hideKeyboard()
		setUpButtonsAttributes()
		setUpLabelAttributes()
		setUpAmountTextField()
		viewModel.delegate = self
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.barTintColor = UIColor.App.initialBackground
		inputedCurrency.setTitle(viewModel.getFrom(), for: .normal)
		outputedCurrency.setTitle(viewModel.getTo(), for: .normal)
		viewModel.makeRequest(fromTitle: inputedCurrency.title(for: .normal) ?? "FROM", toTitle:  outputedCurrency.title(for: .normal) ?? "TO")
		addNotifications()
		amountDidChange()
	}
	
// MARK: Functions
	func addViews() {
		self.view.addSubview(inputedMoney)
		self.view.addSubview(outputedMoney)
		self.view.addSubview(inputedCurrency)
		self.view.addSubview(outputedCurrency)
	}
	
// MARK: Constraints
	func addContraintsToTextField() {
		
		NSLayoutConstraint.activate([
			inputedMoney.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			inputedMoney.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			inputedMoney.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
			inputedMoney.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
			
		])
	}
	
	func addConstraintsToLabel() {
		NSLayoutConstraint.activate([
			outputedMoney.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
			outputedMoney.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
			outputedMoney.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
			outputedMoney.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3)
		])
	}
	
	func addContraintsToButtons() {
		NSLayoutConstraint.activate([
			inputedCurrency.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
			inputedCurrency.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			inputedCurrency.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4),
			inputedCurrency.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1),
			
			outputedCurrency.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
			outputedCurrency.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
			outputedCurrency.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4),
			outputedCurrency.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.1)
		])
	}
	
	func addNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: .updateLive, object: nil)
	}
	
// MARK: Grafics' attributes
	func setUpLabelAttributes() {
		outputedMoney.textAlignment = .center
		outputedMoney.textColor = .black
		outputedMoney.font = UIFont(name: "HelveticaNeue", size: 20)
		outputedMoney.layer.borderWidth = 2
		outputedMoney.layer.borderColor = UIColor.App.textBorder.cgColor
		outputedMoney.layer.cornerRadius = 10
	}
	
	func setUpButtonsAttributes() {
		inputedCurrency.backgroundColor = UIColor.App.buttons
		inputedCurrency.layer.cornerRadius = 10
		inputedCurrency.setTitleColor(.black, for: .normal)
		inputedCurrency.addTarget(self, action: #selector(showCurrencyViewControllerFrom), for: .touchUpInside)
		
		outputedCurrency.backgroundColor = UIColor.App.buttons
		outputedCurrency.layer.cornerRadius = 10
		outputedCurrency.setTitleColor(.black, for: .normal)
		outputedCurrency.addTarget(self, action: #selector(showCurrencyViewControllerTo), for: .touchUpInside)
	}
	
	private func setUpAmountTextField() {
		inputedMoney.addTarget(self, action: #selector(amountDidChange), for: .editingChanged)
	}
	

// MARK: @objc
	@objc func reloadUI() {
		viewModel.updateLive()
	}
	
	@objc func showCurrencyViewControllerFrom () {
		viewModel.presentCurrencyViewController(buttonType: "FROM")
	}
	
	@objc func showCurrencyViewControllerTo () {
		viewModel.presentCurrencyViewController(buttonType: "TO")
	}
	
	@objc func amountDidChange() {
		viewModel.initialAmount = inputedMoney.text ?? ""
		viewModel.conversionTo()
	}
	
	
}
// MARK: Extension
extension InitialViewController: InitialViewModelDelegate {
	func updateInput(result: String) {
		inputedMoney.text = result
	}
	
	func updateResult(result: String) {
		outputedMoney.text = result
	}
}

