//
//  UIButtons+Actions.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class BTGButton: UIButton {

	var onClick: (() -> Void)?
	
	override init(frame: CGRect) {
		super.init(frame: .zero)
		addAction()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addAction() {
		self.addTarget(self, action: #selector(self.wasClicked), for: .touchUpInside)
	}
	
	@objc private func wasClicked() {
		onClick?()
	}
}
