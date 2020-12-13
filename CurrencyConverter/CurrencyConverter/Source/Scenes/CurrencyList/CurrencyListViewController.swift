//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    lazy var contentView = CurrencyListView()
        .run {
            $0.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        }
    
    // MARK: - Initializers
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        view = contentView
    }
    
    // MARK: - Actions
    
    @objc func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
}
