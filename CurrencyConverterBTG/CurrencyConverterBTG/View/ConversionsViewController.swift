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
        view.backgroundColor = DesignSystem.Color.primary
        
        originBtn.setTitle("Origin", for: .normal)
        originBtn.tintColor = DesignSystem.Color.white
        originBtn.titleLabel?.numberOfLines = 0
        originBtn.titleLabel?.textAlignment = .center
        originBtn.addTarget(self, action: #selector(didSelectOrigin), for: .touchUpInside)
        originBtn.backgroundColor = DesignSystem.Color.secondary
        originBtn.layer.cornerRadius = DesignSystem.Button.getCornerRadius(view: view)
        
        destinyBtn.setTitle("Destiny", for: .normal)
        destinyBtn.tintColor = DesignSystem.Color.white
        destinyBtn.titleLabel?.numberOfLines = 0
        destinyBtn.titleLabel?.textAlignment = .center
        destinyBtn.addTarget(self, action: #selector(didSelectDestiny), for: .touchUpInside)
        destinyBtn.backgroundColor = DesignSystem.Color.secondary
        destinyBtn.layer.cornerRadius = DesignSystem.Button.getCornerRadius(view: view)
        
        conversionArrow.image = UIImage(systemName: "arrow.right")
        conversionArrow.tintColor = DesignSystem.Color.tertiary
        
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
            originBtn.widthAnchor.constraint(equalToConstant: DesignSystem.Button.getWidth(view: view)),
            originBtn.heightAnchor.constraint(equalToConstant: DesignSystem.Button.getHeight(view: view)),
            destinyBtn.widthAnchor.constraint(equalToConstant: DesignSystem.Button.getWidth(view: view)),
            destinyBtn.heightAnchor.constraint(equalToConstant: DesignSystem.Button.getHeight(view: view)),
            conversionArrow.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor),
            conversionArrow.leftAnchor.constraint(equalTo: originBtn.rightAnchor, constant: DesignSystem.marginsPadding),
            conversionArrow.rightAnchor.constraint(equalTo: destinyBtn.leftAnchor, constant: -DesignSystem.marginsPadding),
            conversionArrow.widthAnchor.constraint(equalTo: conversionArrow.heightAnchor),
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
