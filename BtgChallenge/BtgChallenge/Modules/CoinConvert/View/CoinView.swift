//
//  CoinView.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

enum CoinType {
    case from
    case to // swiftlint:disable:this identifier_name
}

class CoinView: UIView {

    // MARK: - Constants
    
    static let height: CGFloat = 52
    
    // MARK: - Properties
    
    lazy var titleLabel: BtgLabel = {
        let label = BtgLabel()
        label.text = "Você está convertendo de"
        
        return label
    }()
    
    lazy var coinButton: BtgCoinButton = {
        let button = BtgCoinButton()
        return button
    }()
    
    lazy var valueLabel: BtgLabelLarge = {
        let label = BtgLabelLarge()
        label.text = "0.00"
        label.textColor = coinType == .from ? UIColor.softBlue : UIColor.softGreen
        return label
    }()
    
    let coinType: CoinType
    
    // MARK: - View Lyfe Cycle
    
    init(coinType: CoinType) {
        self.coinType = coinType
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.coinType = .from
        super.init(coder: coder)
    }
    
}

// MARK: - View Coded
extension CoinView: ViewCoded {
    func setupViewHierarhy() {
        addSubview(titleLabel)
        addSubview(coinButton)
        addSubview(valueLabel)
    }
    
    func setupConstraints() {
        snp.makeConstraints { (make) in
            make.height.equalTo(CoinView.height)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        coinButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
