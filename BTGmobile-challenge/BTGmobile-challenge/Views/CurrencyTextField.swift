//
//  CurrencyTextField.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 09/10/20.
//

import Foundation
import UIKit

final class CurrencyTextField: UITextField, UITextFieldDelegate {

	override init(frame: CGRect) {
		super.init(frame: frame)
		setUpTextFieldAttributes()
		delegate = self
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private func setUpTextFieldAttributes() {
		placeholder = "Enter the currency amount"
		textAlignment = .center
		textColor = .black
		font = UIFont(name: "HelveticaNeue", size: 20)
		layer.borderWidth = 2
		layer.borderColor = UIColor.App.textBorder.cgColor
		layer.cornerRadius = 10
		keyboardType = .numbersAndPunctuation
		returnKeyType = .default
	}
	
	internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		return true
	}
}
