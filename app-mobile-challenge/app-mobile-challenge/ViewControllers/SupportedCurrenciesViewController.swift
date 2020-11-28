//
//  SupportedCurrenciesViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

class SupportedCurrenciesViewController: UIViewController {
    
    @AutoLayout private var backButton: BackButtonView

    private var viewModel: SupportedCurrenciesViewModel
    
    init(viewModel: SupportedCurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        layoutViews()
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
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    //MARK: - objcs
    @objc private func back() {
        viewModel.back()
    }
    
    //MARK: - Layout
    private func layoutViews() {
        layoutButton()
    }
    
    private func layoutButton() {
        view.addSubview(backButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            backButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Back.height),
            backButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Back.width)
        ])
    }
}
