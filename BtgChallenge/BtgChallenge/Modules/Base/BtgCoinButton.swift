//
//  BtgCoinButton.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class BtgCoinButton: UIView {

    // MARK: - Constants
    
    static let buttonHeight: CGFloat = 20
    static let buttonWidth: CGFloat = 80
    static let buttonPadding: CGFloat = 8
    static let caretImageSize: CGFloat = 16
    
    // MARK: - Properties
    
    lazy var coinTypeLabel: BtgLabelLarge = {
       let label = BtgLabelLarge()
        label.text = "REAL"
        
        return label
    }()
    
    lazy var caretImageView: BtgImageView = {
        return BtgImageView(imageName: "Caret")
    }()
    
    // MARK: - View Lyfe Cycle
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension BtgCoinButton: ViewCoded {
    func setupViewHierarhy() {
        addSubview(coinTypeLabel)
        addSubview(caretImageView)
    }
    
    func setupConstraints() {
        snp.makeConstraints { (make) in
            make.height.equalTo(BtgCoinButton.buttonHeight)
            make.width.equalTo(BtgCoinButton.buttonWidth)
        }
        
        coinTypeLabel.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        caretImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(BtgCoinButton.buttonPadding)
            make.height.equalTo(BtgCoinButton.caretImageSize)
            make.width.equalTo(BtgCoinButton.caretImageSize)
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
