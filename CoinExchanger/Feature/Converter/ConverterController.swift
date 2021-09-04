//
//  ConverterController.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class ConverterController: UIViewController {
    let model = ConverterModel()
    var kb = false
    
    // MARK: View
    let contentView = ConverterView()
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setKeyboard()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

private extension ConverterController {
    // MARK: Setup
    func setup() {
        view.backgroundColor = Asset.Colors.primary.color
        
        view.addSubview(contentView)
        contentView.fill(to: view)
        
        contentView.delegate = self
        contentView.visualDelegate = self
    }
    
    func fetchData() {
        model.fetchCoins()
        model.fetchQuotes()
    }
    
    func updateTargetValue(_ value: Int) {
        
    }
    
    func tabCoin() {
        let mt = model.origin
        model.origin = model.target
        model.target = mt
        
        contentView.originConverter.button.setTitle(model.origin.name, for: .normal)
        contentView.targetConverter.button.setTitle(model.target.name, for: .normal)
        
        let t = contentView.originConverter.inputField.text
        contentView.originConverter.inputField.text = contentView.targetConverter.inputField.text
        contentView.targetConverter.inputField.text = t
    }
    
    // MARK: Completion Handler
    func originCompletion(_ coin: Coin) {
        model.origin = coin
        contentView.originConverter.button.setTitle(model.origin.name, for: .normal)
    }
    
    func targetCompletion(_ coin: Coin) {
        model.target = coin
        contentView.targetConverter.button.setTitle(model.target.name, for: .normal)
    }
    
    // MARK: Keyboard
    func setKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !kb {
                kb = true
                contentView.showKeyboard(with: keyboardSize.height+Helper.safeSize(for: .bottom))
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if kb {
            kb = false
            contentView.hideKeyboard()
        }
    }
}

// MARK: Generic Delegate
extension ConverterController: GenericDelegate {
    func didTouch(_ view: UIView) {
        switch view.tag {
        case 1:
            //present(CoinListController(originCompletion), animated: true)
            show(CoinListController(originCompletion), sender: self)
        case 2:
            //present(CoinListController(targetCompletion), animated: true)
            show(CoinListController(targetCompletion), sender: self)
        case 3:
            tabCoin()
        default:
            break
        }
    }
}

// MARK: VisualInput Delegate
extension ConverterController: VisualInputDelegate {
    func didBeginEditing(_ input: VisualInput) { }
    
    func didChange(_ input: VisualInput) { }
    
    func didEndEditing(_ input: VisualInput, _ valid: Bool) { }
    
    func didReturn(_ input: VisualInput) { }
}
