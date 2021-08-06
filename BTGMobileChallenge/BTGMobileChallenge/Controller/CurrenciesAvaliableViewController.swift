//
//  CurrenciesAvaliableViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class CurrenciesAvaliableViewController: BTGViewController {

	private let tableView = UITableView()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupUI()
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		bindUI()
	}
	
	private func setupUI() {
		view.addSubview(tableView)
		self.setupTableView()
		self.setupConstraints()
	}
	
	private func bindUI() {
		
	}
}

// MARK: Layout construction
extension CurrenciesAvaliableViewController {
	private func setupConstraints() {
		let top: NSLayoutYAxisAnchor
		let bottom: NSLayoutYAxisAnchor
		
		if #available(iOS 11.0, *) {
			top = view.safeAreaLayoutGuide.topAnchor
			bottom = view.safeAreaLayoutGuide.bottomAnchor
		} else {
			top = view.topAnchor
			bottom = view.bottomAnchor
		}
		
		tableView.anchor(
			top: (top, 0),
			right: (view.rightAnchor, 0),
			left: (view.leftAnchor, 0),
			bottom: (bottom, 0)
		)
	}
}

// MARK: TableBiew setup
ext
