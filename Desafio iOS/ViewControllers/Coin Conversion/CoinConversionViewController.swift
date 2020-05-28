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
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getList()
    }
    
   // MARK: - Setups
    private func setup() {
        setupObservable()
    }
    
    private func setupObservable() {
        self.viewModel.currencyListObservable.observeOn(MainScheduler.asyncInstance).subscribe(onNext: { result in
            result?.currencies?.coinsDictionary.forEach( {print($0.value )})
        }).disposed(by: viewModel.disposeBag)
    }
}
