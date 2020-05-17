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
    var isSearching = false
    
    var tableView : UITableView!
    var dataSource : UITableViewDiffableDataSource<Section,CurrencyDescription>!
    var modalSelection: AvaliableCurrencySelection?
    
    var currencyDescriptions : [CurrencyDescription] = []
    var currencyDescriptionsFiltered : [CurrencyDescription] = []
    weak var currencySelectionDelegate : CurrencySelectionHandler?
    
    var controller : CurrencyListController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller?.getCurrencyToCurrencyReceiver()
        //isSearching = false
        updateDataSource()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        currencySelectionDelegate?.setKeyboardNecessary(to: true)
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
        configureSearchController()
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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(showSortAlertController))
        
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
//        print(currencyDescriptions,"ˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆˆ", currencyDescriptionsFiltered)
        if isSearching && !currencyDescriptionsFiltered.isEmpty {
            snapshot.appendItems(currencyDescriptionsFiltered)
        } else if !currencyDescriptions.isEmpty && !isSearching {
            snapshot.appendItems(currencyDescriptions)
        } else {
            return
        }
        
        DispatchQueue.main.async {
            if self.dataSource.snapshot().itemIdentifiers != snapshot.itemIdentifiers {
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        }
    }
    
    func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Procure moedas aqui. Ex: USD"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    func setCurrencyDescriptions(currencyDescriptions : [CurrencyDescription]) {
        self.currencyDescriptions = currencyDescriptions
        updateDataSource()
    }
    
    @objc func dismissModal() {
        dismiss(animated: true)
    }
    
    @objc func showSortAlertController() {
        let alertController = UIAlertController(title: "Sorting Currencies", message: "How do you like to sort your Currencies?", preferredStyle: .actionSheet)
        alertController.isSpringLoaded = true

        let orderByAbbreviationButton = UIAlertAction(title: "Abbreviation", style: .default, handler: {
            [weak self] _ -> Void in
            guard let self = self else { return }
            self.currencyDescriptions = self.currencyDescriptions.sorted(by: { d1, d2 -> Bool in
                d1.abbreviation < d2.abbreviation
                
            })
            self.updateDataSource()
            
        })
        
        let orderByFullDescriptionButton = UIAlertAction(title: "Full Name", style: .default, handler: {
            [weak self] _ -> Void in
            guard let self = self else { return }
            self.currencyDescriptions = self.currencyDescriptions.sorted(by: { d1, d2 -> Bool in
                d1.fullDescription < d2.fullDescription
            })
            self.updateDataSource()
            
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(orderByAbbreviationButton)
        alertController.addAction(orderByFullDescriptionButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true) // here there's a bug on apple's native alertController framework that break the constraints, the workaround is using animated false and setting directly the alertController to the view.
    }
    
}

extension BTGCurrencyListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isModalView {
            switch modalSelection! {
            case .base:
                currencySelectionDelegate?.setBaseCurrency(currencyAbbreviation:
                    isSearching ? currencyDescriptionsFiltered[indexPath.row].abbreviation : currencyDescriptions[indexPath.row].abbreviation  )
            case .target:
                currencySelectionDelegate?.setTargetCurrency(currencyAbbreviation: isSearching ? currencyDescriptionsFiltered[indexPath.row].abbreviation : currencyDescriptions[indexPath.row].abbreviation)
            }
            currencySelectionDelegate?.setKeyboardNecessary(to : true)
            dismiss(animated: true)
        }
    }
    
}

extension BTGCurrencyListVC: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        currencyDescriptionsFiltered = currencyDescriptions.filter {
            $0.abbreviation.lowercased().contains(filter.lowercased()) ||
                $0.fullDescription.lowercased().contains(filter.lowercased())
        }
        updateDataSource()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateDataSource()
        searchBar.searchTextField.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            isSearching = false
            updateDataSource()
        }
    }
}
