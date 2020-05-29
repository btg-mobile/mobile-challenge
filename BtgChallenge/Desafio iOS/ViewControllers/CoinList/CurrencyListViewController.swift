//
//  CoinConversionViewController.swift
//  Desafio iOS
//
//  Created by Lucas Soares on 28/05/20.
//  Copyright © 2020 Lucas Soares. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol CurrencyListViewControllerDelegate: class {
    func didSelectNewCurrency(formattedCurrency: FormattedCurrency, source: CurrencySource)
}

class CurrencyListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tbCurrencies: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Properties
    let viewModel: CurrencyListViewModelProtocol
    private let CELL_IDENTIFIER = "currencyCell"
    weak var delegate: CurrencyListViewControllerDelegate?
    
    // MARK: - Initializer
    init(viewModel: CurrencyListViewModelProtocol, delegate: CurrencyListViewControllerDelegate?) {
        self.viewModel = viewModel
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.getList()
    }
    
   // MARK: - Setups
    private func setup() {
        setupTableView()
    }
    
    private func setupTableView() {
        
        self.tbCurrencies.register(UITableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER)
        
        self.searchBar.placeholder = "Digite código ou nome da moeda..."
        
        self.searchBar.rx
            .text
            .distinctUntilChanged()
            .flatMapLatest( { query -> Observable<[FormattedCurrency]> in
                return self.viewModel.filterList(predicate: query ?? "")
            })
            .bind(to: self.tbCurrencies.rx.items(cellIdentifier: CELL_IDENTIFIER, cellType: UITableViewCell.self)) { row, model, cell in
                cell.selectionStyle = .none
                cell.textLabel?.text = String(format: "%@ - %@", model.currencyCode, model.currencyFullName)
            }.disposed(by: viewModel.disposeBag)
        
        self.tbCurrencies.rx.modelSelected(FormattedCurrency.self).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] model in
            guard let self = self else {
                return
            }
            self.handleModelSelection(formatedCurrency: model)
        }).disposed(by: viewModel.disposeBag)
        
    }
    
    // MARK: - Handle model selection
    private func handleModelSelection(formatedCurrency: FormattedCurrency) {
        self.delegate?.didSelectNewCurrency(formattedCurrency: formatedCurrency, source: self.viewModel.currencySource)
        self.navigationController?.popViewController(animated: true)
    }
}
