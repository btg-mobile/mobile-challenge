//
//  BTGConversorViewController.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import UIKit

final class BTGConversorViewController: UIViewController {
    
    var viewModel: BTGConversorViewModel
    
    init(_ viewModel: BTGConversorViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should not be used")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
