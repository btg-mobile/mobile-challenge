//
//  CoinConversionViewController.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CoinConversionViewController: UIViewController {

    // MARK: - Properties
    let viewModel: CoinConversionViewModelProtocol
    
    // MARK: - Initializer
    init(viewModel: CoinConversionViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
