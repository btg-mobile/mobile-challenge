//
//  CurrencyConverterViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

class CurrencyConverterViewController: UIViewController {
    
    @AutoLayout private var currencyButton: CurrencyButtonView

    private var viewModel: CurrencyConverterViewModel
    
    init(viewModel: CurrencyConverterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        layoutConstraints()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    //MARK: - SetUp
    private func setUpViews() {
        setUpButton()
    }
    
    private func layoutConstraints() {
        layoutButton()
    }
    
    //MARK: - Views setUp
    private func setUpButton() {
        currencyButton.addTarget(self, action: #selector(openList), for: .touchUpInside)
    }
    
    //MARK: - objcs
    @objc private func openList() {
        viewModel.pickSupporteds()
    }
    
    //MARK: - Layout
    private func layoutButton() {
        view.addSubview(currencyButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            currencyButton.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            currencyButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            currencyButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.height),
            currencyButton.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor,
                multiplier: DesignSystem.Button.widthMultiplier)
        ])
    }
}

