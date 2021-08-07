//
//  appStrings.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import Foundation

class AppStrings {
	var fromCurrencCellTitle: String { return getString(forKey: "fromCurrencCellTitle") }
	var toCurrencCellTitle: String { return getString(forKey: "toCurrencCellTitle") }
	var clickToChoiceTip: String { return getString(forKey: "clickToChoiceTip") }
	
	private func getString(forKey key: String) -> String {
		return Bundle.main.localizedString(forKey: key, value: nil, table: "AppStrings")
	}
}
