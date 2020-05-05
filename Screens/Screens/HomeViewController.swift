//
//  HomeViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 29/04/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Combine

class HomeViewController: UIViewController, Drawable {
    
    private let homeView = HomeView()
    override func loadView() { view = homeView }
    override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
    private let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        homeView.draw()
        draw()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refresh()
    }
    
    func stylizeViews() {
        homeView.otherCurrenciesTableView.refreshControl?.tintColor = .init(white: 1, alpha: 0.8)
    }
    
    func createViewsHierarchy() {
        let refreshControl = UIRefreshControl()
        homeView.otherCurrenciesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
    }
    
    private func refresh() {
        
        if !(homeView.otherCurrenciesTableView.refreshControl?.isRefreshing ?? false) {
            let refreshControl = homeView.otherCurrenciesTableView.refreshControl!
            refreshControl.beginRefreshing()
            homeView.otherCurrenciesTableView.setContentOffset(CGPoint(x: 0, y: -refreshControl.frame.height), animated: true)
        }
        
        viewModel
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.alert(error)
                case .finished:
                    break
                }
            }) { (model) in
                    self.homeView.quote = .init(
                        value: String(format: "%.2f", arguments: [model.default.model.value]),
                        firstCurrency: model.default.model.first,
                        secondCurrency: model.default.model.second,
                        lastUpdate: "Updated \(model.default.updatedAt.elapsedTime()) ago")
                let transformed = model.quotes.map { quote in
                    HomeView.Cell.Model(
                        value: String(format: "%.2f", arguments: [quote.model.value]),
                        currenciesPair: "\(quote.model.first) to \(quote.model.second)",
                        lastSeen: quote.updatedAt.formattedHour())
                }
                self.homeView.otherCurrencies = transformed
                self.homeView.otherCurrenciesTableView.refreshControl?.endRefreshing()
            }.store(in: &cancellables)
    }
    
    @objc private func handleRefresh(_ control: UIRefreshControl) {
        refresh()
    }
}
