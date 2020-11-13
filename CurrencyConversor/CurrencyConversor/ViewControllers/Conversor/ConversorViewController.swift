//
//  ConversorViewController.swift
//  CurrencyConversor
//
//  Created by Erick Mitsugui Yamato on 05/11/20.
//

import UIKit

private enum Constants {
    static let usd                             = "USD"
    static let currency                        = "Currency"
    static let currencyViewController          = "CurrencyViewController"
    static let timeInterval: Double            = 1800
    static let defaultConversionAmount: Double = 1
    static let fractionDigits: Int             = 2
    static let patternRegex                    = "[^0-9]"
}

protocol SelectedCellDelegate {
    func selectedCell(_ cellText: String)
}

class ConversorViewController: UIViewController {
    
    private var exchangeRates: [ExchangeRate]?
    private var convertedRates: [ExchangeRate]?
    private var origin: String?
    private var destiny: String?
    private var conversionAmount: Double = Constants.defaultConversionAmount
    private var isOrigin: Bool           = true
    private var defaultCurrencyCode      = Constants.usd
    
    // MARK: Properties
    @IBOutlet weak var originButton: UIButton!
    @IBOutlet weak var destinyButton: UIButton!
    @IBOutlet weak var typeValueTextField: UITextField!
    @IBOutlet weak var currencyConvertedLabel: UILabel!
    
    // MARK: Life Cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTexts()
        applyStyle()
        setupInputAccessories()
        loadLiveExchangeRates()
        typeValueTextField.delegate = self
    }
    
    // MARK: Setup Methods
    private func setupTexts() {
        originButton.setTitle(StringIdentifier.origin.getString(), for: .normal)
        destinyButton.setTitle(StringIdentifier.destiny.getString(), for: .normal)
        
        typeValueTextField.placeholder = StringIdentifier.typeValuePlaceholder.getString()
        
        currencyConvertedLabel.text = StringIdentifier.currencyConverted.getString() 
    }
    
    private func applyStyle() {
        typeValueTextField.keyboardType = .numberPad
    }
    
    private func setupInputAccessories() {
        addInputAccessoryForTextFields(textFields: [typeValueTextField],
                                       dismissable: true,
                                       previousNextable: false)
    }
    
    private func setupOriginTextButton(originTextButton: String) {
        originButton.setTitle(originTextButton, for: .normal)
        origin = originTextButton
    }
    
    private func setupDestinyTextButton(destinyTextButton: String) {
        destinyButton.setTitle(destinyTextButton, for: .normal)
        destiny = destinyTextButton
    }
    
    private func setupCurrencyConvertedLabel(convertedValue: String) {
        currencyConvertedLabel.text = "\(StringIdentifier.currencyConverted.getString()) \(convertedValue)"
    }
    
    private func presentCurrencyViewController() {
        let storyboard = UIStoryboard(name: Constants.currencyViewController, bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: Constants.currencyViewController) as CurrencyViewController
        vc.delegate = self
        present(vc,
                animated: true,
                completion: nil)
    }
    
    // MARK: Functions
    private func loadLiveExchangeRates() {
        LiveExchangeRequest.sharedInstance.getLiveExchange(
            success: { [weak self] response in
                guard let `self` = self else { return }
                DispatchQueue.main.async {
                    self.exchangeRates = response?.quotes.compactMap({
                        ExchangeRate(
                            currency: $0.0.replacingOccurrences(of: self.defaultCurrencyCode, with: "",
                                                                options: String.CompareOptions.literal,
                                                                range: $0.0.range(of: self.defaultCurrencyCode)),
                            value: $0.1)
                    })
                    .sorted() { $0.currency < $1.currency }
                    
                    Timer.scheduledTimer(withTimeInterval: Constants.timeInterval, repeats: true) { timer in
                        self.loadLiveExchangeRates()
                    }
                }
            },
            failure: { [weak self] error in
                guard let `self` = self else { return }
                if let error = error {
                    debugPrint(error.info)
                    
                }
            })
    }
    
    private func convertCurrencies(from: String?, to: String?, amount: String) {
        
        let fromCurrencyRate = exchangeRates?.filter({
            $0.currency == from
        })
        
        let toCurrencyRate = exchangeRates?.filter({
            $0.currency == to
        })
        
        guard let amountValue = Double(amount, withDecimalReplacement: true),
              let fromValue   = Double(fromCurrencyRate?.first?.formattedValue ?? String(), withDecimalReplacement: true),
              let toValue     = Double(toCurrencyRate?.first?.formattedValue ?? String(), withDecimalReplacement: true)
        else {
            return
        }
        
        convertedRates = exchangeRates?.map({
            if fromCurrencyRate?.first?.currency == defaultCurrencyCode {
                conversionAmount = toValue * amountValue
            } else if fromCurrencyRate?.first?.currency == toCurrencyRate?.first?.currency {
                conversionAmount = amountValue
            } else {
                let convertedValue = toValue * amountValue
                
                conversionAmount   = convertedValue / (fromValue * amountValue)
            }
            
            return ExchangeRate(
                currency: $0.currency,
                value: $0.value)
            
        })
        
        setupCurrencyConvertedLabel(convertedValue: formatToCurrencyString(value: conversionAmount) )
        
    }
    
    // Essa chamada funciona apenas no modo pago - ErrorResponse.code = 105 - ErrorResponse.info = "The user's current subscription plan does not support the requested API function."
    
    //    private func convertCurrencies(from: String, to: String, amount: String) {
    //        CurrencyConversionRequest.sharedInstance.convertCurrency(from: from,
    //                                                                 to: to,
    //                                                                 amount: amount,
    //                                                                 success: { [weak self] response in
    //                                                                    guard let `self` = self else { return }
    //                                                                    DispatchQueue.main.async {
    //                                                                        self.setupCurrencyConvertedLabel(convertedValue: String(response?.result ?? 0))
    //                                                                    }
    //                                                                 },
    //                                                                 failure: { [weak self] error in
    //                                                                    guard let `self` = self else { return }
    //                                                                    if let error = error {
    //                                                                        debugPrint(error.info)
    //                                                                    }
    //
    //                                                                 })
    //    }
    
    private func formatToCurrencyString(value: Double) -> String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle               = .decimal
        formatter.roundingMode              = .down
        formatter.maximumFractionDigits     = Constants.fractionDigits
        formatter.minimumFractionDigits     = Constants.fractionDigits
        formatter.currencyGroupingSeparator = StringIdentifier.doubleSymbol.getString()
        formatter.currencyDecimalSeparator  = StringIdentifier.decimalSymbol.getString()
        
        return formatter.string(from: NSNumber(value:value)) ?? String()
    }
    
    // MARK: Actions
    @IBAction func didTapOriginButton(_ sender: Any) {
        isOrigin = true
        presentCurrencyViewController()
    }
    
    @IBAction func didTapDestinyButton(_ sender: Any) {
        isOrigin = false
        presentCurrencyViewController()
    }
    
    @IBAction func typeValueTextFieldEditingChanged(_ sender: Any) {
        if let value = typeValueTextField.text?.currencyFormatting() {
            typeValueTextField.text = value
        }
    }
    
    
}

// MARK: UITextFieldDelegate
extension ConversorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
//        convertCurrencies(from: origin,
//                          to: destiny,
//                          amount: textField.text ?? String())
        convertCurrencies(from: origin ?? defaultCurrencyCode,
                          to: destiny ?? defaultCurrencyCode,
                          amount: textField.text ?? "1")
    }
}

// MARK: SelectedCellDelegate
extension ConversorViewController: SelectedCellDelegate {
    func selectedCell(_ cellText: String) {
        if isOrigin {
            setupOriginTextButton(originTextButton: cellText)
        } else {
            setupDestinyTextButton(destinyTextButton: cellText)
        }
    }
    
}

extension String {
    
    func currencyFormatting() -> String {
        
        var number: NSNumber!
        let formatter                       = NumberFormatter()
        formatter.numberStyle               = .decimal
        formatter.maximumFractionDigits     = Constants.fractionDigits
        formatter.minimumFractionDigits     = Constants.fractionDigits
        formatter.currencyGroupingSeparator = StringIdentifier.doubleSymbol.getString()
        formatter.currencyDecimalSeparator  = StringIdentifier.decimalSymbol.getString()
        
        var amountWithPrefix = self
        
        let regex = try? NSRegularExpression(pattern: Constants.patternRegex, options: .caseInsensitive)
        
        amountWithPrefix = (regex?.stringByReplacingMatches(in: amountWithPrefix,
                                                            options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                            range: NSMakeRange(0, self.count),
                                                            withTemplate: ""))!
        
        let double = (amountWithPrefix as NSString).doubleValue
        number = NSNumber(value: (double / 100))
        
        guard number != 0 as NSNumber else {
            return String()
        }
        
        return formatter.string(from: number)!
    }
    
    func doubleConversion() -> Double {
        return NumberFormatter().number(from: self)?.doubleValue ?? 0.0
    }
    
}
