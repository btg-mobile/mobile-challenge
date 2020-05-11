//
//  ListViewController.swift
//  BTG Converser
//
//  Created by Vandcarlos Mouzinho Sandes Junior on 11/05/20.
//  Copyright © 2020 Vandcarlos Mouzinho Sandes Junior. All rights reserved.
//

import UIKit

final class ListViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var orderCodeButton: UIButton!
    @IBOutlet weak var orderNameButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    private var listItems: [ListItem] = []

    private lazy var presenter: ListPresenterToView = {
        return ListPresenter(view: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
    }

    @IBAction func sortByCodeTapped(_ sender: Any) {
        self.presenter.sortByCodeTapped()
    }

    @IBAction func sortByNameTapped(_ sender: Any) {
        self.presenter.sortByNameTapped()
    }
}

extension ListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.presenter.filterListItems(with: searchBar.text)
    }

}

extension ListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCodeCell.identifier,
            for: indexPath
        ) as! ListCodeCell

        let listItem = self.listItems[indexPath.row]

        cell.codeNameLabel.text = "\(listItem.code) - \(listItem.name)"

        return cell
    }

}

extension ListViewController: UITableViewDelegate {

}

// MARK: - ListViewToPresenter

extension ListViewController: ListViewToPresenter {

    func updateListItems(_ listItems: [ListItem]) {
        self.listItems = listItems
        self.tableView.reloadData()
    }

    func showStateSortByCodeAsc() {
        self.orderCodeButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        self.orderNameButton.setImage(nil, for: .normal)
    }

    func showStateSortByCodeDesc() {
        self.orderCodeButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        self.orderNameButton.setImage(nil, for: .normal)
    }

    func showStateSortByNameAsc() {
        self.orderNameButton.setImage(UIImage(systemName: "arrow.up"), for: .normal)
        self.orderCodeButton.setImage(nil, for: .normal)
    }

    func showStateSortByNameDesc() {
        self.orderNameButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
        self.orderCodeButton.setImage(nil, for: .normal)
    }

}
