//
//  CurrenciesViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 30/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Combine

class CurrenciesViewController: UINavigationController, Drawable {
    
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let viewModel = CurrenciesViewModel()
    private var cancellables = Set<AnyCancellable>()
    private weak var tableViewController: CurrenciesTableViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    override func didReceiveMemoryWarning() {
        cancellables.removeAll()
    }
    
    private func refresh() {
        
        if !(tableViewController.refreshControl?.isRefreshing ?? false) {
            let refreshControl = tableViewController.refreshControl!
            refreshControl.beginRefreshing()
            tableViewController.tableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.height), animated: true)
        }
        
        viewModel
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.alert(error)
                case .finished:
                    self.tableViewController.refreshControl?.endRefreshing()
                }
            }) { currencies in
                self.tableViewController.currencies = currencies.sorted()
            }.store(in: &cancellables)
    }
    
    @objc private func handleRefresh(_ control: UIRefreshControl) {
        refresh()
    }
    
    func stylizeViews() {
        tableViewController.refreshControl?.tintColor = .init(white: 1, alpha: 0.8)
    }
    
    func createViewsHierarchy() {
        let tableViewController = CurrenciesTableViewController()
        self.tableViewController = tableViewController
        pushViewController(tableViewController, animated: false)
        
        let refreshControl = UIRefreshControl()
        tableViewController.tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    }
}

