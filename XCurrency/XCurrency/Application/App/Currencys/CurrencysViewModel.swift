//
//  CurrencysViewModel.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

class CurrencysViewModel: GenericModel {

    // MARK: - Attributes
    private var currencys: [Currency] = [Currency(name: "Dolar Americano", code: "USD"), Currency(name: "Real Brasileiro", code: "BRL"), Currency(name: "Euro", code: "EU")]

    // MARK: - Public Methods
    func presentCurrencys() {
        self.router.present()
    }

    func getCurrencys() -> [Currency] {
        return self.currencys
    }

    func getCurrency(position: Int) -> Currency? {
        return position <= (currencys.count - 1) ? self.currencys[position] : nil
    }

    func dismiss() {
        self.router.dismiss()
    }
}
