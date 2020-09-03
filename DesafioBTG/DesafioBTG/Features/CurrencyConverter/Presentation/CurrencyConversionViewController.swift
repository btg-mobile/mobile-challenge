//
//  CurrencyConversionViewController.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyConversionViewController: UIViewController {
    // MARK: UI Components
    
    let containerView = UIView()
    let firstCurrencyLabelDescription = UILabel()
    let firstCurrencyTextFieldSelector = UITextField()
    let equalSignalImage = UIImageView()
    let secondCurrencyLabelDescription = UILabel()
    let secondCurrencyTextFieldSelector = UITextField()
    let firstButton = UIButton()
    let secondButton = UIButton()
    
    // MARK: Variables
    
    let viewModel = CurrencyConversionViewModel(withBusiness: CurrencyConverterBusinessModel())
    let disposeUIBag = DisposeBag()
    private var firstAppearing = true
    var firstCurrencyLabelDescriptionHeightConstraint: NSLayoutConstraint?
    var secondCurrencyLabelDescriptionHeightConstraint: NSLayoutConstraint?
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstAppearing {
            self.setupUI()
            self.bindUI()
            self.firstAppearing = false
        }
        
        showObstructiveLoading()
        self.viewModel.rx_updateListValues().observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.hideObstructiveLoading()
        }, onError: { error in
            //TO-DO: TRATAR ERRO
            self.hideObstructiveLoading()
        }).disposed(by: self.disposeUIBag)
    }
    
    // MARK: - Setup UI
    
    func setupUI() {
        setupNavigation()
        setupBackground()
        setupContainer()
        setupCurrencyFields()
        self.view.layoutIfNeeded()
    }
    
    private func fitViewYAxisToContainer(_ view: UIView) {
        view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: -24).isActive = true
        view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: 24).isActive = true
    }
    
    private func setupDescriptionLabelLayout(_ label: UILabel) {
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
    }
    
    private func setupFieldLayout(_ field: UITextField) {
        field.font = UIFont.systemFont(ofSize: 16)
        field.textAlignment = .left
        field.placeholder = "Select a currency"
        field.borderStyle = .roundedRect//0, 97, 188
        field.tintColor = UIColor(red: 0.0, green: 97/255, blue: 188/255, alpha: 1.0)
        field.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)
        field.keyboardType = .numberPad
    }
    
    private func setupNavigation() {
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 251/255,
                                                                           green: 160/255,
                                                                           blue: 40/255,
                                                                           alpha: 1.0)
        self.navigationController?.navigationBar.isOpaque = true
        let navImage = UIImageView(image: UIImage(named: "navigationImage"))
        
        navImage.widthAnchor.constraint(equalToConstant: (self.navigationController?.navigationBar.frame.size.height ?? 70) - 12).isActive = true
        navImage.heightAnchor.constraint(equalToConstant: (self.navigationController?.navigationBar.frame.size.height ?? 70) - 12).isActive = true
        navImage.contentMode = .scaleAspectFit
        
        self.navigationItem.titleView = navImage
    }
    
    func setupBackground() {
        self.view.backgroundColor = UIColor(red: 252/255,
                                            green: 227/255,
                                            blue: 116/255,
                                            alpha: 1.0)
    }
    
    func setupContainer() {
        self.view.addSubview(self.containerView)
        
        self.containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.containerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.666, constant: 0).isActive = true
        
        self.containerView.backgroundColor = .clear
        
        self.containerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupCurrencyFields() {
        self.containerView.addSubview(self.firstCurrencyLabelDescription)
        self.firstCurrencyLabelDescription.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        self.firstCurrencyLabelDescriptionHeightConstraint = self.firstCurrencyLabelDescription.heightAnchor.constraint(equalToConstant: 30)
        self.firstCurrencyLabelDescriptionHeightConstraint?.isActive = true
        self.fitViewYAxisToContainer(self.firstCurrencyLabelDescription)
        self.firstCurrencyLabelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.setupDescriptionLabelLayout(firstCurrencyLabelDescription)
        
        self.containerView.addSubview(self.firstCurrencyTextFieldSelector)
        self.firstCurrencyTextFieldSelector.topAnchor.constraint(equalTo: firstCurrencyLabelDescription.bottomAnchor, constant: 2).isActive = true
        self.firstCurrencyTextFieldSelector.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.fitViewYAxisToContainer(self.firstCurrencyTextFieldSelector)
        self.firstCurrencyTextFieldSelector.translatesAutoresizingMaskIntoConstraints = false
        self.setupFieldLayout(firstCurrencyTextFieldSelector)
        
        self.containerView.addSubview(self.equalSignalImage)
        self.equalSignalImage.topAnchor.constraint(equalTo: firstCurrencyTextFieldSelector.bottomAnchor, constant: 24).isActive = true
        self.equalSignalImage.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.equalSignalImage.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.equalSignalImage.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.equalSignalImage.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        self.equalSignalImage.contentMode = .scaleAspectFit
        self.equalSignalImage.image = UIImage(named: "equalSignal")
        self.equalSignalImage.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(self.secondCurrencyLabelDescription)
        self.secondCurrencyLabelDescription.topAnchor.constraint(equalTo: equalSignalImage.bottomAnchor, constant: 24).isActive = true
        self.secondCurrencyLabelDescriptionHeightConstraint = self.secondCurrencyLabelDescription.heightAnchor.constraint(equalToConstant: 30)
        self.secondCurrencyLabelDescriptionHeightConstraint?.isActive = true
        self.fitViewYAxisToContainer(self.secondCurrencyLabelDescription)
        self.secondCurrencyLabelDescription.translatesAutoresizingMaskIntoConstraints = false
        self.setupDescriptionLabelLayout(secondCurrencyLabelDescription)
        
        self.containerView.addSubview(secondCurrencyTextFieldSelector)
        self.secondCurrencyTextFieldSelector.topAnchor.constraint(equalTo: secondCurrencyLabelDescription.bottomAnchor, constant: 2).isActive = true
        self.secondCurrencyTextFieldSelector.heightAnchor.constraint(equalToConstant: 60).isActive = true
        fitViewYAxisToContainer(secondCurrencyTextFieldSelector)
        self.secondCurrencyTextFieldSelector.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        self.secondCurrencyTextFieldSelector.translatesAutoresizingMaskIntoConstraints = false
        self.setupFieldLayout(secondCurrencyTextFieldSelector)
    }
    
    private func setupButtons() {
        self.containerView.addSubview(firstButton)
        firstButton.topAnchor.constraint(equalTo: self.firstCurrencyLabelDescription.topAnchor).isActive = true
        firstButton.leadingAnchor.constraint(equalTo: self.firstCurrencyLabelDescription.leadingAnchor).isActive = true
        firstButton.trailingAnchor.constraint(equalTo: self.firstCurrencyLabelDescription.trailingAnchor).isActive = true
        firstButton.bottomAnchor.constraint(equalTo: self.firstCurrencyTextFieldSelector.bottomAnchor).isActive = true
        
        self.containerView.addSubview(secondButton)
        secondButton.topAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.topAnchor).isActive = true
        secondButton.leadingAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.leadingAnchor).isActive = true
        secondButton.trailingAnchor.constraint(equalTo: self.secondCurrencyLabelDescription.trailingAnchor).isActive = true
        secondButton.bottomAnchor.constraint(equalTo: self.secondCurrencyTextFieldSelector.bottomAnchor).isActive = true
        
        firstButton.alpha = 0.0
        firstButton.setTitle(nil, for: .normal)
        secondButton.alpha = 0.0
        secondButton.setTitle(nil, for: .normal)
    }
    
    // MARK: - Bind UI
    
    func bindUI() {
        self.firstCurrencyLabelDescription.rx.observe(String.self, "text")
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let text = event.element, let self = self else { return }
                let isEmpty = text?.isEmpty ?? false
                
                self.firstCurrencyLabelDescriptionHeightConstraint?.constant = isEmpty ? 0 : 30
                self.view.layoutIfNeeded()
        }.disposed(by: self.disposeUIBag)
        
        self.secondCurrencyLabelDescription.rx.observe(String.self, "text")
            .observeOn(MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let text = event.element, let self = self else { return }
                let isEmpty = text?.isEmpty ?? false
                
                self.secondCurrencyLabelDescriptionHeightConstraint?.constant = isEmpty ? 0 : 30
                self.view.layoutIfNeeded()
        }.disposed(by: self.disposeUIBag)
        
        self.firstButton.rx.tap.observeOn(MainScheduler.instance).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.showCurrencySelector(forFirstCurrency: true)
        }.disposed(by: self.disposeUIBag)
        
        self.secondButton.rx.tap.observeOn(MainScheduler.instance).subscribe { [weak self] _ in
            guard let self = self else { return }
            self.showCurrencySelector(forFirstCurrency: false)
        }.disposed(by: self.disposeUIBag)
        
        self.firstCurrencyTextFieldSelector.rx.observe(String.self, "text")
            .observeOn(MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe {[weak self] event in
                guard let text = event.element, let self = self else {return}
        }.disposed(by: self.disposeUIBag)
        
        self.viewModel.bindFirstCurrencyTo(label: self.firstCurrencyLabelDescription)
        self.viewModel.bindSecondCurrencyTo(label: self.secondCurrencyLabelDescription)
    }
    
    // MARK: - UI Methods
    
    func showCurrencySelector(forFirstCurrency: Bool) {
        let selectVC = CurrencySelectorViewController(nibName: nil, bundle: nil)
        selectVC.viewModel = CurrencySelectorViewModel(withBusiness: self.viewModel.businessWithProtocol(CurrencySelectorProtocol.self))
        selectVC.isSelectingFirstCurrency = forFirstCurrency
        
        self.present(selectVC, animated: true)
    }
    
    func switchFirstButtonLayout()
}
