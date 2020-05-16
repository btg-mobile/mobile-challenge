//
//  BTGCurrencyListVC.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

enum Section {
    case main
}

protocol CurrencyListReceiver: UIViewController {
    func setCurrencyDescriptions(currencyDescriptions : [CurrencyDescription])
}

class BTGCurrencyListVC: UIViewController, CurrencyListReceiver {
    
    var isModalView = false
    
    var tableView : UITableView!
    var dataSource : UITableViewDiffableDataSource<Section,CurrencyDescription>!
    var modalSelection: AvaliableCurrencySelection?
    
    var currencyDescriptions : [CurrencyDescription] = []
    weak var currencySelectionDelegate : CurrencySelectionHandler?
    
    var controller : CurrencyListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller?.getCurrencyToCurrencyReceiver()
        print("view will appear")
    }
    
    init(isModalView: Bool = false, currencySelectionHandler : CurrencySelectionHandler? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.isModalView = isModalView
        
        if isModalView {
            guard let currencySelectionHandler = currencySelectionHandler else { fatalError() }
            self.currencySelectionDelegate = currencySelectionHandler
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        configureViewController()
        configureTableView()
        configureDataSource()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        controller = BTGCurrencyListController(currencyListReceiver: self)
        if isModalView {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissModal))
            title = "Select Currency"
        } else {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(showSortAlertController))
        
    }
    
    private func configureTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.backgroundColor = .systemBackground
        tableView.register(CurrencyDescriptionCell.self , forCellReuseIdentifier: CurrencyDescriptionCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ])
        
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section,CurrencyDescription>(tableView: tableView!, cellProvider: { (tableView, indexPath, currencyDescription) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyDescriptionCell.reuseID, for: indexPath) as? CurrencyDescriptionCell
            cell?.set(currencyDescription)
            return cell
        })
    }
    
    private func updateDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section,CurrencyDescription>()
        snapshot.appendSections([.main])
        snapshot.appendItems(currencyDescriptions)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func setCurrencyDescriptions(currencyDescriptions : [CurrencyDescription]) {
        self.currencyDescriptions = currencyDescriptions
        updateDataSource()
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
    @objc func showSortAlertController() {
        let alertController = UIAlertController(title: "Order", message: "Como você gostaria de ordenar as moedas?", preferredStyle: .actionSheet)
        
        
        let orderByAbbreviationButton = UIAlertAction(title: "Por sigla", style: .default, handler: {
            [weak self] _ -> Void in
            guard let self = self else { return }
            self.currencyDescriptions = self.currencyDescriptions.sorted(by: { d1, d2 -> Bool in
                d1.abbreviation < d2.abbreviation
                
            })
            self.updateDataSource()
            
        })
        
        //        let  deleteButton = UIAlertAction(title: "Delete forever", style: .Destructive, handler: { (action) -> Void in
        //            print("Delete button tapped")
        //        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        
        alertController.addAction(orderByAbbreviationButton)
        //alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true) // here there's a bug on apple's native alertController framework that break the constraints, the workaround is using animated false and setting directly the alertController to the view.
    }
    
}

extension BTGCurrencyListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(currencyDescriptions[indexPath.row].abbreviation)")
        if isModalView {
            switch modalSelection! {
            case .base:
                currencySelectionDelegate?.setBaseCurrency(currencyAbbreviation: currencyDescriptions[indexPath.row].abbreviation)
            case .target:
                currencySelectionDelegate?.setTargetCurrency(currencyAbbreviation: currencyDescriptions[indexPath.row].abbreviation)
            }
            dismiss(animated: true)
        }
    }
}
