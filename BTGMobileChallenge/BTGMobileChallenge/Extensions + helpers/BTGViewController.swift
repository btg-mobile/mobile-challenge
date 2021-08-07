//
//  BTGViewController.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 05/08/21.
//

import UIKit

class BTGViewController: UIViewController {

	private let mainView: UIView = {
		let view = UIView(frame: UIScreen.main.bounds)
		view.backgroundColor = .white
		
		return view
	}()
	private lazy var loadingView: UIView = {
		let loadIndicator = UIActivityIndicatorView(style: .large)
		let loadView = UIView()
		
		loadView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
		loadView.layer.cornerRadius = 10
		loadView.addSubview(loadIndicator)
		loadIndicator.anchor(
			centerX: (loadView.centerXAnchor, 0),
			centerY: (loadView.centerYAnchor, 0)
		)
		
		loadIndicator.startAnimating()
		
		return loadView
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view = view
    }
	
	override func loadView() {
		self.view = mainView
	}
}

// MARK: Handler Loading
extension BTGViewController {
	public func showLoading() {
		DispatchQueue.main.async {
			self.view.addSubview(self.loadingView)
			self.loadingView.anchor(
				centerX: (self.view.centerXAnchor, 0),
				centerY: (self.view.centerYAnchor, 0),
				height: 150,
				width: 200
			)
		}
	}
	
	public func hideLoading() {
		DispatchQueue.main.async {
			self.loadingView.removeFromSuperview()
		}
	}
}

// MARK: HAndler Error
extension BTGViewController {

}
