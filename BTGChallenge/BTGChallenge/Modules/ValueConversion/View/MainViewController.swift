//
//  MainViewController.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 08/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var toConvertLbl: UILabel!
    @IBOutlet weak var toBeConvertedLbl: UILabel!
    
    required init() {
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func openCurrencyListToBeConverted(_ sender: Any) {
        guard let navigation = self.navigationController else { return }
        let coordinator = CurrencyListCoordinator(navigation: navigation, targertViewController: self)
        let _ = coordinator.start(with: .sheetView(animated: false))
    }
    
    
    @IBAction func openCurrencyListToConvert(_ sender: Any) {
        guard let navigation = self.navigationController else { return }
        let coordinator = CurrencyListCoordinator(navigation: navigation, targertViewController: self)
        let _ = coordinator.start(with: .sheetView(animated: false))
    }
}
