//
//  ConvertViewController.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class ConvertViewController: UIViewController {
    
    weak var coordinator:MainCoordinator?
    
    let baseView = ConvertView()
    
    override func loadView() {
        super.loadView()
        self.view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        addTriggers()
    }
}

//MARK: - Triggers
extension ConvertViewController{
    
    func addTriggers(){
        baseView.changeButtonOrigin.addTarget(self, action: #selector(self.actionChangeButtonOrigin(_:)), for: .touchUpInside)
    }
    
    @objc func actionChangeButtonOrigin(_ sender: Any){
        
        coordinator?.navigateToCurrencyViewController()
    }
}
