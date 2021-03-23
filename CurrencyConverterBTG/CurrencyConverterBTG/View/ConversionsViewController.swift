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
    
    override func viewDidLoad() {
        originBtn.setTitle("Origin", for: .normal)
        destinyBtn.setTitle("Destiny", for: .normal)
        conversionArrow.image = UIImage(systemName: "arrow.right")
        
        view.addSubview(originBtn)
        view.addSubview(destinyBtn)
        view.addSubview(conversionArrow)
        
        addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            originBtn.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            originBtn.rightAnchor.constraint(equalTo: conversionArrow.leftAnchor),
            conversionArrow.rightAnchor.constraint(equalTo: destinyBtn.leftAnchor),
            destinyBtn.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor),
            originBtn.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            conversionArrow.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor),
            destinyBtn.centerYAnchor.constraint(equalTo: originBtn.centerYAnchor)
        ])
    }
}
