//
//  Extensions.swift
//  BTGmobile-challenge
//
//  Created by Cassia Aparecida Barbosa on 07/10/20.
//

import Foundation
import UIKit

extension UIColor {
	struct App {
		static var initialBackground: UIColor { return UIColor.init(red: 193/255, green: 224/255, blue: 239/255, alpha: 1) }
		static var buttons: UIColor { return .systemBlue }
		static var textBorder: UIColor { return UIColor.init(red: 15/255, green: 46/255, blue: 63/255, alpha: 1) }
	}
}


extension Errors: LocalizedError {
	var errorDescription: String? {
		switch self {
			case .userDefaults:
				return "There is no case of value on UserDefaults."
		}
	}
}

extension UIViewController {
	func hideKeyboard() {
		let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
}


extension Notification.Name {
	static let updateList = Notification.Name("updateList")
	static let updateLive = Notification.Name("updateLive")
	static let emptyData = Notification.Name("emptyData")
}

