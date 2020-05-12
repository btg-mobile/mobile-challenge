//
//  ListPresenterToView.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

protocol ListPresenterToView: class {

    func viewDidLoad()
    func filterListItems(with query: String?)

    func sortByCodeTapped()
    func sortByNameTapped()

}
