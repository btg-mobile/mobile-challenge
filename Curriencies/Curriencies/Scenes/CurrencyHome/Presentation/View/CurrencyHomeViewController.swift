//
//  CurrencyHomeViewController.swift
//  Curriencies
//
//  Created by Ferraz on 31/08/21.
//

import UIKit

protocol HomeActionsProtocol: AnyObject {
    func tapOriginButton()
    func tapDestinationButton()
}

final class CurrencyHomeViewController: UIViewController {
    
    let viewModel: CurrencyViewModeling
    
    private lazy var screen: CurrencyHomeScreen = {
        let screen = CurrencyHomeScreen()
        screen.buttonActions = self
        
        return screen
    }()
    
    init(viewModel: CurrencyViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.getCurrencies {
            print("a")
        }
    }
    
    override func loadView() {
        view = screen
    }
}

extension CurrencyHomeViewController: HomeActionsProtocol {
    func tapOriginButton() {
        print("1")
    }
    
    func tapDestinationButton() {
        print("2")
    }
}
