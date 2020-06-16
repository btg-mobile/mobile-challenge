//
//  MainViewController.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 08/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var buttonToConvert: UIButton!
    @IBOutlet weak var buttonToBetConverted: UIButton!
    @IBOutlet weak var buttonConvert: UIButton!
    @IBOutlet weak var toBeConvertedLbl: UILabel!
    
    var viewModel: CurrencyLiveViewModelContract
    
    required init(with viewModel: CurrencyLiveViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetch()
    }
    
    func fetch() {
        self.viewModel.fetch { result in
            switch result {
            case .success(let success):
                print("Sucess: \(success)")
                return
            case .failure(let error):
                self.showAlert(title: "Atenção", message: error.localizedDescription)
            }
        }
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
