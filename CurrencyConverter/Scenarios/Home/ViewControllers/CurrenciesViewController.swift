//
//  CurrenciesViewController.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol CurrenciesViewControllerDelegate: AnyObject {
    //func userDidSelectCurrencie(currencie: CurrencieModel)
}

final class CurrenciesViewController: UIViewController, CurrenciesStoryboardLodable {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var fromLabel: UILabel!
    @IBOutlet private weak var toLabel: UILabel!
    @IBOutlet private weak var sortButton: UIButton!

    // MARK: - Properties

    var viewModel: CurrenciesViewModel!
    weak var delegate: CurrenciesViewControllerDelegate?

    // MARK: - Fields

    private var disposeBag = DisposeBag()
    private let doneButton: UIBarButtonItem
    private let searchController: UISearchController

    required init?(coder aDecoder: NSCoder) {
        doneButton = UIBarButtonItem(title: "Converter", style: .plain, target: nil, action: nil)
        searchController = UISearchController(searchResultsController: nil)

        super.init(coder: aDecoder)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupBinding()
        setupData()
    }

    // MARK: - Setup

    private func setupUI() {
        //Title
        title = "Selecione as moedas"
        
        //Done Button
        navigationItem.rightBarButtonItem = doneButton
        
        //TableView
        tableView.estimatedRowHeight = 0
        tableView.rowHeight = 60
        
        //Search Controller
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    private func setupBinding() {
        //TableView
        tableView.rx
            .modelSelected(CurrencieModel.self).bind { [weak self] currencie in
                self?.viewModel.tapCurrencie()
            }.disposed(by: disposeBag)
        tableView.rx
            .itemSelected.bind { [weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            }.disposed(by: disposeBag)
        doneButton.rx.tap.bind { [weak self] in
            self?.viewModel.tapConvert()
        }.disposed(by: disposeBag)
        
        //IndicatorView
        viewModel.isLoading.observeOn(MainScheduler.instance).bind(to: indicatorView.rx.isAnimating).disposed(by: disposeBag)
        
        //Labels and Buttons
        sortButton.rx.tap.bind { [weak self] in
            self?.viewModel.tapSortButton()
            if let az = self?.viewModel.sortAZ.value {
                self?.sortButton.setTitle(az ? "Ordenar (A-Z)" : "Ordenar (Z-A)", for: .normal)
            }
        }.disposed(by: disposeBag)
        
        //Search Controller
        searchController.searchBar[keyPath: \.searchTextField].placeholder = "Digite a sigla ou o nome da moeda"
        searchController.searchBar[keyPath: \.searchTextField].font = UIFont(name: "Helvetica", size: 15)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancelar"
        
        searchController.searchBar.rx.text.throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance).bind(to: viewModel.filter).disposed(by: disposeBag)
        searchController.searchBar.rx.textDidBeginEditing.bind { [weak self] in self?.searchController.searchBar.setShowsCancelButton(true, animated: true) }.disposed(by: disposeBag)
        
        searchController.searchBar.rx.cancelButtonClicked.bind { [weak self] in
            self?.searchController.searchBar.resignFirstResponder()
            self?.searchController.searchBar.setShowsCancelButton(false, animated: true)
            self?.viewModel.filter.accept(nil)
            self?.searchController.searchBar.text = nil
        }.disposed(by: disposeBag)
    }

    private func setupData() {
        tableView.register(cellType: CurrencieCell.self)

        viewModel.currencies
            .bind(to: tableView.rx.items(cellIdentifier: CurrencieCell.reuseIdentifier, cellType: CurrencieCell.self)) { _, element, cell in
                cell.model = element
            }.disposed(by: disposeBag)
    }
}
