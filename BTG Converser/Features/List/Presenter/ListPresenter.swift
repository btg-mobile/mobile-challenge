//
//  ListPresenter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import Foundation

final class ListPresenter {

    unowned private let view: ListViewToPresenter

    private lazy var interactor: ListInteractorToPresenter = {
        return ListInteractor(presenter: self)
    }()

    init (view: ListViewToPresenter) {
        self.view = view
    }

    private var listItems: [ListItem] = []

    private var currentQuery = ""
    private var currentOrderKey = OrderKey.code
    private var currentOrderOrientation = OrderOrientation.asc


    enum OrderKey {
        case code
        case name
    }

    enum OrderOrientation {
        case asc
        case desc
    }

    private func checkListItemsWithOrderAndFilter() {
        var listItems = self.listItems

        if !currentQuery.isEmpty {
            listItems = listItems.filter {
                $0.code.lowercased().contains(self.currentQuery) ||
                $0.name.lowercased().contains(self.currentQuery)
            }
        }

        switch self.currentOrderKey {
        case .code:
            if self.currentOrderOrientation == .asc {
                listItems = listItems.sorted(by: { $0.code < $1.code } )
                self.view.showStateSortByCodeAsc()
            } else {
                listItems = listItems.sorted(by: { $0.code > $1.code } )
                self.view.showStateSortByCodeDesc()
            }

        case .name:
            if self.currentOrderOrientation == .asc {
                listItems = listItems.sorted(by: { $0.name < $1.name } )
                self.view.showStateSortByNameAsc()
            } else {
                listItems = listItems.sorted(by: { $0.name > $1.name } )
                self.view.showStateSortByNameDesc()
            }
        }

        self.view.updateListItems(listItems)
    }

}

// MARK: - ListPresenterToView

extension ListPresenter: ListPresenterToView {

    func viewDidLoad() {
        self.interactor.fetchCurrencies()
    }

    func filterListItems(with query: String?) {
        self.currentQuery = query?.lowercased() ?? ""
        self.checkListItemsWithOrderAndFilter()
    }

    func sortByCodeTapped() {
        self.currentOrderKey = .code
        self.currentOrderOrientation = self.currentOrderOrientation == .asc ? .desc : .asc
        self.checkListItemsWithOrderAndFilter()
    }

    func sortByNameTapped() {
        self.currentOrderKey = .name
        self.currentOrderOrientation = self.currentOrderOrientation == .asc ? .desc : .asc
        self.checkListItemsWithOrderAndFilter()
    }

}

// MARK: - ListPresenterToInteractor

extension ListPresenter: ListPresenterToInteractor {

    func didFetchCurrencies(_ listItems: [ListItem]) {
        self.listItems = listItems
        self.checkListItemsWithOrderAndFilter()
    }

}
