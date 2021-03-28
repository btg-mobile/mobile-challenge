//
//  CurrencysViewController.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencysViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var segmentControll: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Attributes
    private let viewModel: CurrencysViewModel

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: Initializers
    init(currencysViewModel: CurrencysViewModel) {
        self.viewModel = currencysViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Actions
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
