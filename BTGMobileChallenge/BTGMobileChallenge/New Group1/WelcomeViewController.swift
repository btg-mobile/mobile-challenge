//
//  WelcomeViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class WelcomeViewController: BTGViewController {

	private let viewtest = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		
		self.navigationItem.title = "Main"
		view.backgroundColor = .white
		view.addSubview(viewtest)
		viewtest.backgroundColor = .purple
		
		viewtest.anchor(
			top: (view.topAnchor, 10),
			right: (view.rightAnchor, 10),
			left: (view.leftAnchor, 10),
			bottom: (view.bottomAnchor, 10)
		)
	}
}

