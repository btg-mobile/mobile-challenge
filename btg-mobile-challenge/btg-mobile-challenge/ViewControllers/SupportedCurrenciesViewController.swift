//
//  SupportedCurrenciesViewController.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 03/10/20.
//

import UIKit

final class SupportedCurrenciesViewController: UIViewController {
    @AutoLayout private var currenciesTableView: UITableView

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
