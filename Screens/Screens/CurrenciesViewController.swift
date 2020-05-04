//
//  CurrenciesViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 30/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Combine

class CurrenciesViewController: UINavigationController, Drawable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let viewModel = CurrenciesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private weak var tableViewController: CurrenciesTableViewController!
    
    init() {
        let tableViewController = CurrenciesTableViewController()
        self.tableViewController = tableViewController
        super.init(rootViewController: tableViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
                print(512)
            }) { currencies in
                self.tableViewController.currencies = currencies.sorted()
            }.store(in: &cancellables)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

