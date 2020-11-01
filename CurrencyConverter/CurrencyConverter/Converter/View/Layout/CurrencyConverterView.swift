//
//  CurrencyConverterView.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 30/10/20.
//

import UIKit

protocol CurrencyConverterViewDelegate: class {
    func textFormatting(_ text: String?) -> (input: String, output: String)
}

class CurrencyConverterView: UIView {
    
    weak var delegate: CurrencyConverterViewDelegate?
    
    // MARK: - Layout Vars
    private lazy var titleOriginLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.height(constant: 20)
        return label
    }()
    
    private lazy var valueOriginTextField: UITextField = {
        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.lightGray, .font: UIFont.systemFont(ofSize: 20)]
        let textField = UITextField().useConstraint()
        textField.attributedPlaceholder = NSAttributedString(string: "Value", attributes: attributes)
        textField.textColor = .white
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.keyboardType = .numberPad
        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
        textField.height(constant: 26)
        textField.delegate = self
        return textField
    }()
    
    private lazy var stackViewOrigin: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleOriginLabel, valueOriginTextField]).useConstraint()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var titleTargetLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.height(constant: 20)
        return label
    }()
    
    private lazy var valueTargetLabel: UILabel = {
        let label = UILabel().useConstraint()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.height(constant: 26)
        return label
    }()
    
    private lazy var stackViewTarget: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleTargetLabel, valueTargetLabel]).useConstraint()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView().useConstraint()
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK: - Life Cycle
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    // MARK: - Setups
    private func setupLayout() {
        addSubview(stackViewOrigin)
        addSubview(stackViewTarget)
        addSubview(separatorView)
        
        stackViewOrigin
            .top(anchor: topAnchor, constant: 8)
            .leading(anchor: leadingAnchor, constant: 8)
            .trailing(anchor: trailingAnchor, constant: -8)
        
        stackViewTarget
            .top(anchor: stackViewOrigin.bottomAnchor, constant: 24)
            .leading(anchor: leadingAnchor, constant: 8)
            .trailing(anchor: trailingAnchor, constant: -8)
            .bottom(anchor: bottomAnchor, constant: -8)
        
        separatorView
            .top(anchor: stackViewOrigin.bottomAnchor, constant: 12)
            .leading(anchor: leadingAnchor, constant: 8)
            .trailing(anchor: trailingAnchor)
            .height(constant: 1)
    }
    
    func setupCurrency(_ currency: Currecy, type: CurrencyType) {
        switch type {
        case .origin:
            titleOriginLabel.text = currency.fullDescription
        case .target:
            titleTargetLabel.text = currency.fullDescription
        }
    }
}

// MARK: - TextField
extension CurrencyConverterView: UITextFieldDelegate {
    @objc func textDidChange(_ textField: UITextField) {
        let texts = delegate?.textFormatting(textField.text)
        textField.text = texts?.input
        valueTargetLabel.text = texts?.output
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: string))
    }
}
