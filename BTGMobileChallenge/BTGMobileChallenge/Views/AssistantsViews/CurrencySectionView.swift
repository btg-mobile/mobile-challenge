//
//  CurrencySectionView.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import UIKit

class CurrencySectionView: UIView {
	private let titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private let clickHereView: UIView = {
		let view = UIView()
		let label = UILabel()
		view.addSubview(label)
		
		label.text = AppStrings().clickToChoiceText
		view.backgroundColor = .red
		
		label.anchor(
			centerX: (view.centerXAnchor, 0),
			centerY: (view.centerYAnchor, 0)
		)
		
		return view
	}()
	private let currencyView: UIView = {
		let view = UIView()
		return view
	}()
	private let codeLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private let valueLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	private let separatorView: UIView = {
		let view = UIView()
		return view
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupUI()
	}
	
	convenience init(title: String) {
		self.init(frame: .zero)
		titleLabel.text = title
		setupUI()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupUI() {
		addSubview(titleLabel)
		addSubview(clickHereView)
		addSubview(currencyView)
		currencyView.addSubview(codeLabel)
		currencyView.addSubview(valueLabel)
		
		setupConstraints()
	}
	
	private func setupConstraints() {
		titleLabel.anchor(
			top: (topAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20)
		)
		
		clickHereView.anchor(
			top: (titleLabel.bottomAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (bottomAnchor, 20),
			height: 44
		)
		
		currencyView.anchor(
			top: (titleLabel.bottomAnchor, 20),
			right: (rightAnchor, 20),
			left: (leftAnchor, 20),
			bottom: (bottomAnchor, 20),
			height: 44
		)
		
		codeLabel.anchor(
			left: (currencyView.leftAnchor, 0),
			centerY: (currencyView.centerYAnchor, 0)
		)
		
		valueLabel.anchor(
			left: (codeLabel.rightAnchor, 20),
			centerY: (currencyView.centerYAnchor, 0)
		)
	}
	
	func showCurrency(code: String, value: Float) {
		DispatchQueue.main.async { [weak self] in
			guard let self = self else { return }
			self.clickHereView.removeFromSuperview()
			self.codeLabel.text = code
			self.valueLabel.text = "\(value)"
		}
	}
}
