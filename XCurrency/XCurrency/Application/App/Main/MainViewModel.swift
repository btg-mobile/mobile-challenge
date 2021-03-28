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

    func presentCurrencySelector(order: CurrencyOrder, selectedCurrency: @escaping (Currency) -> Void) {
        (self.router as! MainRouter).presentCurrencysView(order: order, selectedCurrency: selectedCurrency)
    }
}
