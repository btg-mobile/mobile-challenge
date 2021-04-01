//
//  CurrencyConverterVC.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 31/03/21.
//

import UIKit

class CurrencyConverterVC: UIViewController {

    private let viewModel = RealTimeRatesViewModel()
    
    private lazy var contentView: CurrencyConverterView = {
        let view = CurrencyConverterView(viewModel: viewModel)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.mainStackView.changeBackgroundColor(color: UIColor.cyan)
        contentView.stackView1.changeBackgroundColor(color: UIColor.yellow)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fetchDetails()
    }
    
    private func fetchDetails() {
        self.viewModel.fetchDetails { success in
            if success {
//                self.dataSource.setViewModel(viewModel: self.viewModel)
//                self.contentView.setDataSource(self.dataSource)
            } else {
//                self.handleError()
                print("Error")
            }
        }
    }
}

