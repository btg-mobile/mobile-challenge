//
//  ChooseCurrencyView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 26/11/20.
//

import UIKit

enum TagButton: Int {
    case origin = 0
    case destiny = 1
}

class ChooseCurrencyView : UIStackView {
    var topStack: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .firstBaseline
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var bottomStack: UIStackView = {
        var stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.spacing = 20
        stack.alignment = .firstBaseline
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
        
    var originCurrencyButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("---", for: .normal)
        let textColor = QuotationColors.buttonTextColor.color
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = QuotationColors.currencyButton.color
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        button.tintColor = textColor
        button.semanticContentAttribute = .forceRightToLeft
        button.tag = TagButton.origin.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textValueToConvert: UITextField = {
        var text = UITextField(frame: .zero)
        text.placeholder = "0.00"
        text.font = UIFont.systemFont(ofSize: 20)
        text.textAlignment = .right
        text.backgroundColor = QuotationColors.textFiledBackground.color
        text.borderStyle = .roundedRect
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    var destinyCurrencyButton: UIButton = {
        var button = UIButton(frame: .zero)
        button.setTitle("---", for: .normal)
        let textColor = QuotationColors.buttonTextColor.color
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = QuotationColors.currencyButton.color
        let image = UIImage(systemName: "chevron.down")
        button.setImage(image, for: .normal)
        button.tintColor = textColor
        button.semanticContentAttribute = .forceRightToLeft
        button.tag = TagButton.destiny.rawValue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var resultLabel: UILabel = {
        var label = UILabel(frame: .zero)
        label.textColor = QuotationColors.resultLabel.color
        label.textAlignment = .right
        label.text = "0.00"
        label.font = UIFont.systemFont(ofSize: 28)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var buttonHeight: CGFloat {
        return 50
    }
    
    var buttonWidth: CGFloat {
        return 100
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChooseCurrencyView: ViewCodable {
    func setupHierarchy() {
        addSubview(topStack)
        addSubview(bottomStack)
        
        topStack.addArrangedSubview(originCurrencyButton)
        topStack.addArrangedSubview(textValueToConvert)
        
        bottomStack.addArrangedSubview(destinyCurrencyButton)
        bottomStack.addArrangedSubview(resultLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            topStack.topAnchor.constraint(equalTo: topAnchor),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            destinyCurrencyButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            destinyCurrencyButton.widthAnchor.constraint(equalToConstant: buttonWidth),

            originCurrencyButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            originCurrencyButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            
            textValueToConvert.heightAnchor.constraint(equalToConstant: buttonHeight),
//            textValueToConvert.centerYAnchor.constraint(equalTo: topStack.centerYAnchor),
            
            resultLabel.centerYAnchor.constraint(equalTo: bottomStack.centerYAnchor)
            
        ])
    }
    
    func setupAditionalConfiguration() {
        roundView(view: originCurrencyButton)
        roundView(view: destinyCurrencyButton)
    }
    
    func roundView(view: UIView) {
        view.layer.cornerRadius = 5
    }
}
