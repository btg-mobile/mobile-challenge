//
//  WelcomeViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class WelcomeViewController: BTGViewController {
	
	private let button = BTGButton()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		button.backgroundColor = .blue
		view.addSubview(button)
		button.anchor(
			centerX: (view.centerXAnchor, 0),
			centerY: (view.centerYAnchor, 0),
			height: 44,
			width: 100
		)
		
		button.onClick = {
			self.navigationController?.pushViewController(ConversionViewController(), animated: true)
		}
    }
}
