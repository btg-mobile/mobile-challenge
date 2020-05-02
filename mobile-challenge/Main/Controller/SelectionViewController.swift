//
//  SelectionViewControllerTableViewController.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

private let reuseIdentifer = "SelectionViewCell"

class SelectionViewController: UITableViewController,  UISearchBarDelegate  {
  
  private let searchBar = UISearchBar()
  
  private var sortItem : UIBarButtonItem?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.clearsSelectionOnViewWillAppear = false
    configureNavigationBar()
    self.tableView.separatorStyle = .none
    self.tableView.rowHeight = 60
    self.tableView.register(SelectionViewCell.self, forCellReuseIdentifier: reuseIdentifer)
  }
  
  // MARK: - Configure NavigationBar
  
  func configureNavigationBar() {
    self.searchBar.sizeToFit()
    self.searchBar.delegate = self
    self.searchBar.searchTextField.backgroundColor = .white
    self.searchBar.searchTextField.textColor = UIColor(named: "app_dark")
    self.searchBar.searchTextField.tintColor = UIColor(named: "app_dark")
    self.searchBar.keyboardAppearance = .light
    self.searchBar.setImage(UIImage(systemName: "magnifyingglass" ), for: .search, state: .normal)
    self.searchBar.tintColor = .white
    self.navigationController?.navigationBar.barStyle = .black
    self.navigationController?.navigationBar.tintColor = .white
    sortItem = UIBarButtonItem(image: UIImage(named: "ic_sort"), style: .plain, target: self, action: #selector(handleSortToggle))
    sortItem!.tintColor = .white
    showSearchButton(shouldShow: true)
  }
  
  // MARK: - Configure Sort
  
  @objc func handleSortToggle() {
    print("Sort")
  }
  
  // MARK: - Configure SearchBar
  
  func showSearchButton(shouldShow: Bool){
    if shouldShow {
      self.navigationItem.titleView = nil
      self.searchBar.searchTextField.text = " "
      self.searchBar.searchTextField.text = ""
      let itemRight = UIBarButtonItem(barButtonSystemItem: .search,
                                      target: self,
                                      action: #selector(handleShowSearchBar))
      if let sort = sortItem {
        self.navigationItem.rightBarButtonItems = [sort,itemRight]
      } else {
        self.navigationItem.rightBarButtonItem = itemRight
      }
      searchBar.showsCancelButton = false
    } else {
      self.navigationItem.titleView = searchBar
      self.searchBar.showsCancelButton = true
      self.navigationItem.rightBarButtonItems = nil
      self.searchBar.becomeFirstResponder()
    }
  }
  
  @objc func handleShowSearchBar() {
    showSearchButton(shouldShow: false)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    showSearchButton(shouldShow: true)
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    print("Search bar editing did begin..")
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    view.endEditing(true)
  }
  
  
  // MARK: - Table view data source
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 5
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifer) as! SelectionViewCell
    cell.titleLabel.text = "USD - Dolar"
    
    return cell
  }
  
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
  }
  
}
