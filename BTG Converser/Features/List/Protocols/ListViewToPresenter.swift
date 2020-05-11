//
//  ListViewToPresenter.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol ListViewToPresenter: class {

    func updateListItems(_ listItems: [ListItem])

    func showStateSortByCodeAsc()
    func showStateSortByCodeDesc()
    func showStateSortByNameAsc()
    func showStateSortByNameDesc()

}
