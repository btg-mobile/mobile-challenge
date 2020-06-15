//
//  CurrencyListViewController.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 11/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    
    @IBOutlet weak var mainStack: UIStackView!
    
    var viewModel: CurrencyListViewModelContract!
    
    init (with viewModel: CurrencyListViewModelContract) {
        self.viewModel = viewModel
        super.init(nibName: "CurrencyListViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loading()
        self.fetch()
    }
    
    func fetch () {
        self.viewModel.fetch { result in
            switch result {
            case .success(let data):
                self.setupUI(data: data)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func setupUI(data: [CurrencyListViewData]) {
        self.mainStack.removeAllArrangedSubviews()
        self.sheetViewController?.resize(to: .fullScreen)
        data.forEach({
            self.mainStack.addArrangedSubview(CurrencyList(with: $0))
        })
    }
    
    func loading() {
        self.mainStack.removeAllArrangedSubviews()
        var viewData: [CurrencyListViewData] = []
        for _ in 1...5 {
            viewData.append(CurrencyListViewData(currencyCode: "Loading", currencyName: "Just for Loading"))
        }
        viewData.forEach({
            let view = CurrencyList(with: $0)
            view.startLoading()
            self.mainStack.addArrangedSubview(view)
        })
        
    }
    
}
