//
//  CurrencyListViewController.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    @AutoLayout private var pickerTableView: UITableView
    
    private let viewModel: CurrencyListViewModel
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let viewModel = coder.decodeObject(forKey: "viewModel") as? CurrencyListViewModel else {
            return nil
        }
        self.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }    
}
