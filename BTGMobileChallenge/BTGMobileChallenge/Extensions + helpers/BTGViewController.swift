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
		loadView.addSubview(loadIndicator)
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
	
	public func showLoading() {
		view.addSubview(loadingView)
	}
	
	public func hideLoading() {
		loadingView.removeFromSuperview()
	}
}
