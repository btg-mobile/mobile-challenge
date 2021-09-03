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
    
    private lazy var screen: CurrencyHomeScreen = {
        let screen = CurrencyHomeScreen()
        screen.buttonActions = self
        
        return screen
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
