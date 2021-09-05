//
//  CurrencyListViewController.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    let viewModel: CurrencyListViewModeling
    
    private lazy var screen: CurrencyListScreen = {
        let screen = CurrencyListScreen(tableViewDelegate: self)
        
        return screen
    }()
    
    init(viewModel: CurrencyListViewModeling) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = screen
    }

}

extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier,
                                                 for: indexPath) as? CurrencyTableViewCell
        cell?.setupCell(with: viewModel.cellForItemAt(indexPath.row))
        return cell ?? CurrencyTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectCellAt(indexPath.row)
        dismiss(animated: true)
    }
}
