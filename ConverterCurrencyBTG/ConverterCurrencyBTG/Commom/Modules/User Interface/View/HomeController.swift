//
//  HomeController.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 30/06/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    var presenter: HomePresenterInput!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.viewDidLoad()
    }
}

extension HomeController: HomePresenterOutput {
    
}

