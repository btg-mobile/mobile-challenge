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

protocol CoinViewDelegate: class {
    func didUpdateCurrency(view: CoinView, value: String)
}

class CoinView: UIView {

    // MARK: - Constants
    
    static let height: CGFloat = 52
    
    // MARK: - Properties
    
    lazy var titleLabel: BtgLabel = {
        let label = BtgLabel()
        return label
    }()
    
    lazy var coinButton: BtgCoinButton = {
        let button = BtgCoinButton()
        return button
    }()
    
    lazy var valueTextField: BtgTextField = {
        let label = BtgTextField()
        label.text = "0.00"
        label.textColor = coinType == .from ? UIColor.softBlue : UIColor.softGreen
        return label
    }()
    
    let coinType: CoinType
    weak var delegate: CoinViewDelegate?
    
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
    
    func updateValue(value: String) {
        valueTextField.text = value
    }
    
    var amountTypedString = ""
}

// MARK: - View Coded
extension CoinView: ViewCoded {
    func setupViewHierarhy() {
        addSubview(titleLabel)
        addSubview(coinButton)
        addSubview(valueTextField)
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
        
        valueTextField.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        valueTextField.delegate = self
    }
}

extension CoinView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.count > 0 {
            amountTypedString += string
            let decNumber = NSDecimalNumber(string: amountTypedString).multiplying(by: 0.01)
            textField.text = BtgCurrencyFormatter().format(number: decNumber)
        } else {
            amountTypedString = String(amountTypedString.dropLast())
            if amountTypedString.count > 0 {
                let decNumber = NSDecimalNumber(string: amountTypedString).multiplying(by: 0.01)
                textField.text = BtgCurrencyFormatter().format(number: decNumber)
            } else {
                textField.text = "0.00"
            }
            
        }
        
        delegate?.didUpdateCurrency(view: self, value: textField.text ?? "0.00")
        return false
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        amountTypedString = ""
        return true
    }
}

class BtgCurrencyFormatter {
    
    var formatter = NumberFormatter()
    
    init() {
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
    }
    
    func format(string: String) -> String {
        let number = NSNumber(value: Double(string) ?? 0.0)
        return format(number: number)
    }
    
    func format(number: NSNumber) -> String {
        let newString = formatter.string(from: number)!
        return newString
    }
    
}
