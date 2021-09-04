//
//  ConverterView.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class ConverterView: UIView {
    var bs: NSLayoutConstraint?
    weak var delegate: GenericDelegate? {
        didSet {
            originConverter.delegate = delegate
            targetConverter.delegate = delegate
        } }
    
    weak var visualDelegate: VisualInputDelegate? {
        didSet {
            originConverter.visualDelegate = visualDelegate
            targetConverter.visualDelegate = visualDelegate
        } }
    
    // MARK: View
    let label: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Moderat-Bold-Italic", size: 72)
        label.text = "CoinExchanger"
        label.textAlignment = .center
        label.textColor = Asset.Colors.title.color
        return label
    }()
    
    let button: UIButton = {
        var ico: UIImage?
        
        if #available(iOS 13.0, *) {
            ico = UIImage(systemName: "arrow.up.arrow.down")//"arrow.left.arrow.right"
        }
        
        let button = UIButton(type: .system)
        button.accessibilityHint = L10n.Coin.Converter.switchHint
        button.setImage(ico, for: .normal)
        button.setTitle("", for: .normal)
        button.tag = 3
        button.tintColor = Asset.Colors.title.color
        return button
    }()
    
    let originConverter: ConverterCellView = {
        let view = ConverterCellView(L10n.Coin.Converter.originLabel,
                                     L10n.Coin.Converter.originCoin,
                                     L10n.Coin.Converter.hint)
        view.button.accessibilityHint = L10n.Coin.Converter.originCoinHint
        view.inputField.accessibilityHint = L10n.Coin.Converter.originFieldHint
        view.tag = 1
        return view
    }()
    
    let targetConverter: ConverterCellView = {
        let view = ConverterCellView(L10n.Coin.Converter.targetLabel,
                                     L10n.Coin.Converter.targetCoin,
                                     L10n.Coin.Converter.hint)
        view.button.accessibilityHint = L10n.Coin.Converter.targetCoinHint
        view.inputField.accessibilityHint = L10n.Coin.Converter.targetFieldHint
        view.inputField.isUserInteractionEnabled = false
        view.inputField.backgroundView.layer.borderColor = view.inputField.backgroundView.backgroundColor?.cgColor
        view.tag = 2
        return view
    }()
    
    let emptyView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    // MARK: Override
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Keyboard
    func showKeyboard(with height: CGFloat) {
        bs?.constant = -height-Constants.space
        
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            self.layoutIfNeeded()
        })
    }
    
    func hideKeyboard() {
        bs?.constant = -Constants.space
        
        UIView.animate(withDuration: Constants.animationDelay, animations: {
            self.layoutIfNeeded()
        })
    }
}

private extension ConverterView {
    // MARK: Setup
    func setup() {
        backgroundColor = Asset.Colors.background.color.withAlphaComponent(1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
        
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = false
        
        addSubview(scrollView)
        scrollView.fill(to: self)
        
        scrollView.addSubview(label)
        label.top(equalTo: scrollView, constant: Constants.space*2)
        label.left(equalTo: scrollView, constant: Constants.space)
        label.width(equalTo: self, constant: -Constants.space*2)
        
        scrollView.addSubview(originConverter)
        originConverter.topToBottom(of: label, constant: Constants.space*3)
        originConverter.left(equalTo: scrollView, constant: Constants.space)
        originConverter.width(equalTo: self, constant: -Constants.space*2)
        
        scrollView.addSubview(button)
        button.topToBottom(of: originConverter, constant: Constants.space+2)
        button.centerX(equalTo: originConverter)
        button.size(constant: 40)
        
        scrollView.addSubview(targetConverter)
        targetConverter.topToBottom(of: button, constant: Constants.space)
        targetConverter.left(equalTo: scrollView, constant: Constants.space)
        targetConverter.width(equalTo: self, constant: -Constants.space*2)
        bs = targetConverter.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,
                                                     constant: -Constants.space)
        bs?.isActive = true
        
        button.addTarget(self, action: #selector(didTouch(_:)), for: .touchUpInside)
    }
    
    @objc
    func didTap() {
        originConverter.inputField.resignFirstResponder()
    }
    
    @objc
    func didTouch(_ view: UIView) {
        delegate?.didTouch(view)
    }
}
