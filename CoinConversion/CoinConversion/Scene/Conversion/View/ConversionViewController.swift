//
//  ConversionViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

// MARK: - Main
class ConversionViewController: UIViewController {
    
    @IBOutlet private weak var fromView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizedFromView(sender:)))
            fromView.addGestureRecognizer(gesture)
            
            fromView.setCardLayout()
        }
    }
    
    @IBOutlet private weak var toView: UIView! {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizedToView(sender:)))
            toView.addGestureRecognizer(gesture)
            
            toView.setCardLayout()
        }
    }
    
    var viewModel: ConversionViewModel?
    
    init(viewModel: ConversionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ConversionViewController.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .colorBackground
        
        viewModel?.delegate = self
        viewModel?.setInitialInformation()
        viewModel?.fetchQuotes()
    }
}

// MARK: - Actions methods
extension ConversionViewController {
    @objc private dynamic func refreshButtonTouched() {
        viewModel?.fetchQuotes()
    }
    
    @objc private dynamic func tapGestureRecognizedToView(sender: UITapGestureRecognizer) {
        viewModel?.fetchCurrencies(.to)
    }
    
    @objc private dynamic func tapGestureRecognizedFromView(sender: UITapGestureRecognizer) {
         viewModel?.fetchCurrencies(.from)
    }
}

// MARK: - ConversionViewModelDelegate
extension ConversionViewController: ConversionViewModelDelegate {
    func didSetTitle(_ title: String?) {
        self.title = title
    }
    
    func didSetBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(self.refreshButtonTouched))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    func didStartLoading() {
    }
    
    func didHideLoading() {
    }
    
    func didReloadData() {
    }
    
    func didFail() {
    }
}
