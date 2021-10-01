//
//  HomeController.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

final class HomeController: UIViewController {
    private let customView = HomeView()
    private let viewModel: HomeViewModel
    private let origin: Int?
    private let currency: String?
    
    init(viewModel: HomeViewModel, _ currency: String?, _ origin: Int?) {
        self.viewModel = viewModel
        self.currency = currency
        self.origin = origin
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTargets()
        guard let currency = self.currency, let origin = self.origin else {
            return
        }
        self.didSelectedCurrency(currency, origin: origin)
    }

    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    func didSelectedCurrency(_ currency: String, origin: Int) {
        switch origin {
        case customView.currencyButton.tag:
            customView.currencyButton.setTitle(currency, for: .normal)
            //            viewModel.setSelectedSourceCurrency(currency: currency)
            
        case customView.newCurrencyButton.tag:
            customView.newCurrencyButton.setTitle(currency, for: .normal)
            //            viewModel.setSelectedTargetCurrency(currency: currency)
        default:
            break
        }
    }
    
}

// MARK: - Extensions

extension HomeController {
    private func setTargets() {
        customView.currencyButton.addTarget(viewModel, action: #selector(viewModel.didTapCurrency(_:)), for: .touchUpInside)
        customView.newCurrencyButton.addTarget(viewModel, action: #selector(viewModel.didTapNewCurrency), for: .touchUpInside)
    }

}

