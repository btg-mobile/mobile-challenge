//
//  ConversionsViewController.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

final class ConversionsViewController: UIViewController {
    
    @AutoLayout var originBtn: UIButton
    @AutoLayout var destinyBtn: UIButton
    @AutoLayout var conversionArrow: UIImageView
    
    var viewModel: ConversionsViewModel
    weak var coordinator: MainCoordinator?
    
    init(viewModel: ConversionsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        originBtn.setTitle("Origin", for: .normal)
        originBtn.addTarget(self, action: #selector(didSelectOrigin), for: .touchUpInside)
        
        destinyBtn.setTitle("Destiny", for: .normal)
        destinyBtn.addTarget(self, action: #selector(didSelectDestiny), for: .touchUpInside)
        conversionArrow.image = UIImage(systemName: "arrow.right")
        
        view.addSubview(originBtn)
        view.addSubview(destinyBtn)
        view.addSubview(conversionArrow)
        
        addConstraints()
        
        viewModel.originText.bind { [unowned self] text in
            self.originBtn.setTitle(text, for: .normal)
        }
        
        viewModel.destinyText.bind { [unowned self] text in
            self.destinyBtn.setTitle(text, for: .normal)
        }
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            originBtn.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: DesignSystem.marginsPadding),
            destinyBtn.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -DesignSystem.marginsPadding),
            originBtn.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            originBtn.widthAnchor.constraint(equalToConstant: DesignSystem.getButtonWidth(view: view)),
            destinyBtn.widthAnchor.constraint(equalToConstant: DesignSystem.getButtonWidth(view: view)),
            conversionArrow.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor),
            conversionArrow.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            destinyBtn.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor)
        ])
    }
    
    @objc func didSelectOrigin() {
        coordinator?.chooseOriringCurrency()
    }
    
    @objc func didSelectDestiny() {
        coordinator?.chooseDestinyCurrency()
    }
}
