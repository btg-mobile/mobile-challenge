//
//  CurrencyList.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyList: UITableView {
    public var currencies = Currencies.sample
    
    private lazy var viewModel = CurrencyListViewModel(currencies: currencies)
    
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
        register()
        style()
    }
    
    private func style() {
        separatorStyle = .none
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        sectionHeaderHeight = 42
    }
    
    private func register() {
        register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.self.description())
    }
}

extension CurrencyList: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elementsBy(section: section).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: CurrencyListCell.self.description(), for: indexPath) as? CurrencyListCell else {
            return UITableViewCell()
        }
        cell.setUpComponent(currency: currencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72 //configura o tamanho da celula
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.textLabel?.font = TextStyle.display3.font
            headerView.textLabel?.textColor = DesignSystem.Colors.secondary

        }
    }
}
