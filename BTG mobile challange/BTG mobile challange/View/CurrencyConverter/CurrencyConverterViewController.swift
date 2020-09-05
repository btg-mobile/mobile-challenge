//
//  CurrencyConverterViewController.swift
//  BTG mobile challange
//
//  Created by Uriel Barbosa Pinheiro on 03/09/20.
//  Copyright © 2020 Uriel Barbosa Pinheiro. All rights reserved.
//

import Combine
import UIKit

class CurrencyConverterViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var valueInputTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var originCurrencyPickerView: UIPickerView!
    @IBOutlet weak var destinyCurrencyPickerView: UIPickerView!

    // MARK: - Variables

    private var currencyConversionViewModel = CurrencyConverterViewModel(servicesProvider: CurrencyConverterServiceProvider())
    private var currencyListviewModel = CurrencyListViewModel(servicesProvider: CurrencyListServiceProvider())
    private var convertedCurrencySubscriber: AnyCancellable?
    private var convertedListSubscriber: AnyCancellable?
    private var currencyList: [String]? {
        didSet {
            originCurrencyPickerView.reloadComponent(0)
            destinyCurrencyPickerView.reloadComponent(0)
        }
    }

    // MARK: - Lyfecycle and constructors

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegate()
        setupBindings()
    }

    // MARK: - Private functions

    private func setupDelegate() {
        valueInputTextField.delegate = self
        valueInputTextField.keyboardType = .decimalPad
        originCurrencyPickerView.delegate = self
        originCurrencyPickerView.dataSource = self
        destinyCurrencyPickerView.delegate = self
        destinyCurrencyPickerView.dataSource = self
    }

    private func setupBindings() {
        convertedCurrencySubscriber = currencyConversionViewModel.$convertedValue.receive(on: DispatchQueue.main).map{ "\($0 ?? 0)" }.assign(to: \.resultLabel.text, on: self)
        convertedListSubscriber = currencyListviewModel.$currencyList.receive(on: DispatchQueue.main).map { $0.map{ $0.map{ $0.key } } }.assign(to: \.currencyList, on: self)
    }
}

extension CurrencyConverterViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let originRow = originCurrencyPickerView.selectedRow(inComponent: 0)
        let destinyRow = destinyCurrencyPickerView.selectedRow(inComponent: 0)

        guard let text = textField.text,
            let value = Double(text),
            let originCurrency = currencyList?[originRow],
            let destinyCurrency = currencyList?[destinyRow] else { return }

        currencyConversionViewModel.convert(from: originCurrency, to: destinyCurrency, value: value)
    }
}

extension CurrencyConverterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList?.count ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList?[row]
    }
}

