//
//  BTGCurrencyConverterViewController.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 21/10/21.
//

import Foundation
import UIKit



class BTGCurrencyConverterViewController: UIViewController {
    
    let viewModel: BTGCurrencyConverterViewModel
    
    init(viewModel: BTGCurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension BTGCurrencyConverterViewController {
    
    
}
