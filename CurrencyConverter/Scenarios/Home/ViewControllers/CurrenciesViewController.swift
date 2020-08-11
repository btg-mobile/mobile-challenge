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
    
    // MARK: - Properties

    var viewModel: CurrenciesViewModel!
    weak var delegate: CurrenciesViewControllerDelegate?

    // MARK: - Fields

    private var disposeBag = DisposeBag()
    private let doneButton = UIBarButtonItem(title: "Ok", style: .plain, target: nil, action: nil)
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBinding()
        setupData()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func setupBinding() {
        tableView.rx
            .modelSelected(CurrenciesViewModel.self).bind { [weak self] currencie in
                self?.viewModel.toggleCurrencie(isSelected: currencie.isSelected.value)                
            }.disposed(by: disposeBag)
    }
    
    private func setupData() {
        tableView.register(cellType: CurrencieCell.self)

        viewModel.currencies?
            .asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CurrencieCell.reuseIdentifier, cellType: CurrencieCell.self)) { _, element, cell in
                cell.model = element
            }
            .disposed(by: disposeBag)
    }
}
