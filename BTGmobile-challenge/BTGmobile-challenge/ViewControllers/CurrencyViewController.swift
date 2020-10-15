//
//  CurrencyViewController.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 07/10/20.
//

import UIKit

// MARK: Inicialization
final class CurrencyViewController: UIViewController {
	
	@TemplateView private var tableView: UITableView
	
	let viewModel: CurrencyViewModel
	
	init(viewModel: CurrencyViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.title = "Currencies"
		addViews()
		setUpViews()
		addNotifications()
		self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
		self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
		view.backgroundColor = UIColor.white
		navigationController?.navigationBar.barTintColor = UIColor.white
		navigationController?.navigationBar.prefersLargeTitles = true
    }
	
	@objc func reloadUI() {
		tableView.reloadData()
		viewModel.updateList()
	}
	
	func addNotifications() {
		NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: .updateList, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(showNoDataAlert), name: .emptyData, object: nil)
	}
	
	@objc func showNoDataAlert() {
		let alert = UIAlertController(title: "Data Error", message: "There is no saved data to use app without an active internet connection.", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: { _ in
			self.navigationController?.popToRootViewController(animated: true)
		}))
		self.present(alert, animated: true, completion: nil)
	}
	
	// MARK: Functions
	func addViews() {
		view.addSubview(tableView)
	}
	
	func setUpViews() {
		tableView.dataSource = self
		tableView.delegate = self
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.bottomAnchor.constraint(equalTo:view.bottomAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
		])
		
		tableView.separatorInset = .zero
		
		tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.id)
	}
}


// MARK: Table view delegate
extension CurrencyViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		viewModel.updateCurrency(index: indexPath.row)
		self.navigationController?.popToRootViewController(animated: true)
			
	}
}

// MARK: Table view data source
extension CurrencyViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.numberOfRows()
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.id, for: indexPath) as? CurrencyTableViewCell {
			cell.addViews()
			cell.addContraintsToLabels()
			cell.setupCellContent(initials: viewModel.setupCellCode(index: indexPath.row), name: viewModel.setupCellName(index: indexPath.row))
			return cell
		}
        return UITableViewCell()
	}
}
