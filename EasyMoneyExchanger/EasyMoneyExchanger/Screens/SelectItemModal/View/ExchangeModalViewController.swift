//
//  ExchangeModalViewController.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 12/12/20.
//

import UIKit

class ExchangeModalViewController: UIViewController {

    var selected: String = ""
    var viewModel = SelectItemModalViewModel(coreData: CoreDataManager())
    var updateLabels: UpdateLabels?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.initSupportedList(uiTableView: tableView)
    }

    // MARK: - Outlets

    @IBOutlet weak var modalSearchBar: UISearchBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var modalHeadView: UIView! {
        didSet {
            modalHeadView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Actions

    @IBAction func onPressCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
