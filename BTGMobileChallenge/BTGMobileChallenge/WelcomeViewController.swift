//
//  WelcomeViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class WelcomeViewController: UIViewController {

	private let viewtest = UIView()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		view.backgroundColor = .white
		view.addSubview(viewtest)
		
		viewtest.backgroundColor = .purple
		viewtest.translatesAutoresizingMaskIntoConstraints = false
		viewtest.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
		viewtest.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
		viewtest.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
		viewtest.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
	}

}

