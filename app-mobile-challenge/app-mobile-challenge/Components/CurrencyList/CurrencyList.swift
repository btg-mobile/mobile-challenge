//
//  CurrencyList.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyList: UITableView {
    public var currencies = Currencies.sample
    /// Descreve as moedas favoritas.
    private var favoriteCurrencies: Currencies {
        return currencies.filter({$0.favorite == true})
    }
    /// Descreve todas as moedas.
    private var allCurrencies: Currencies {
        return currencies
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.delegate = self
        self.dataSource = self
        self.backgroundColor = .green
    }
}

extension CurrencyList: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) { return favoriteCurrencies.count }
        else { return allCurrencies.count }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = .red
        return cell
    }
}
