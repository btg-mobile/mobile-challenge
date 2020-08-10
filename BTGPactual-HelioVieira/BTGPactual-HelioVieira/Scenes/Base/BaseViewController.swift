//
//  BaseViewController.swift
//  BTGPactual-HelioVieira
//
//  Created by Helio Junior on 07/08/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private let loadingView: LoadingView = LoadingView.fromNib()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configureLoadingView()
        }
    }

    // MARK: LoadingView
    extension BaseViewController {
        private func configureLoadingView() {
            loadingView.isHidden = true
            loadingView.frame = view.bounds
            view.addSubview(loadingView)
            loadingView.bringSubviewToFront(view)
        }
        
        func showLoading() {
            loadingView.isHidden = false
        }
        
        func closeLoading() {
            DispatchQueue.main.async {
                self.loadingView.isHidden = true
            }
        }
}
