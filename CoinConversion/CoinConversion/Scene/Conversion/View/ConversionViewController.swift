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
}

// MARK: - UIViewController lifecycle
extension ConversionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .colorBackground
        
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .colorDarkishPink,
                               tintColor: .white,
                               title: "Conversão",
                               preferredLargeTitle: true,
                               isSearch: false,
                               searchController: nil
        )
        setupBarButton()
        viewModel?.delegate = self
        viewModel?.fetchQuotes()
    }
}

// MARK: - Private methods
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
    
    private func setupBarButton() {
        let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: nil, action: #selector(self.refreshButtonTouched))
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
}

// MARK: - ConversionViewModelDelegate
extension ConversionViewController: ConversionViewModelDelegate {
    func didStartLoading() {
    }
    
    func didHideLoading() {
    }
    
    func didReloadData() {
    }
    
    func didFail() {
    }
}
