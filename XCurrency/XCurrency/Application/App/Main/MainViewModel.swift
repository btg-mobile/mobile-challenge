//
//  MainViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

class MainViewModel: GenericModel {

    // MARK: - Public Methods
    func presentMain() {
        self.router.present()
    }

    func presentCurrencySelector(order: CurrencyOrder) {
        (self.router as! MainRouter).presentCurrencysView(order: order)
    }
}
