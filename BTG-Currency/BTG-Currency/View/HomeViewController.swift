//
//  HomeViewController.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var inputValueTxtField: UITextField!
    @IBOutlet weak var inputSymbolTxtField: UITextField!
    @IBOutlet weak var outputSymbolTxtField: UITextField!
    @IBOutlet weak var outputValueLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var warningView: UIView!
    
    //MARK: - ViewModel attribute
    private var viewModel: HomeViewModel!
    
    //MARK: - Combine attributes
    private var cancellables = Set<AnyCancellable>()
    private let inputValueSubject = PassthroughSubject<String, Never>()
    private let inputSymbolSubject = PassthroughSubject<String, Never>()
    private let outputSymbolSubject = PassthroughSubject<String, Never>()
    
    var inputValuePublisher: AnyPublisher<String, Never> {
        inputValueSubject.eraseToAnyPublisher()
    }
    var inputSymbolPublisher: AnyPublisher<String, Never> {
        inputSymbolSubject.eraseToAnyPublisher()
    }
    var outputSymbolPublisher: AnyPublisher<String, Never> {
        outputSymbolSubject.eraseToAnyPublisher()
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = Container.shared.resolve(HomeViewModel.self)
        binding()
        
        inputValueTxtField.delegate = self
        inputSymbolTxtField.delegate = self
        outputSymbolTxtField.delegate = self
        
        [inputValueTxtField, inputSymbolTxtField, outputSymbolTxtField].forEach { textField in
            textField?.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:)))
        view.addGestureRecognizer(tap)
        
        convertButton.isEnabled = false
        warningView.isHidden = true
        warningView.layer.cornerRadius = 20
        
        title = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputSymbolTxtField.becomeFirstResponder()
    }
    
    //MARK: - Action methods
    @IBAction func touchConvert(_ sender: UIButton) {
        viewModel.convert()
    }
}

//MARK: - Binding methods
extension HomeViewController {
    private func binding() {
        cancellables = [
            viewModel.connectivityPublisher
                .receive(on: DispatchQueue.main)
                .debounce(for: .seconds(1), scheduler: DispatchQueue(label: "HomeViewController"))
                .sink(receiveValue: { [weak self] isConnected in
                    if !isConnected {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self?.warningView.alpha = 0
                                self?.warningView.isHidden = false
                                self?.warningView.alpha = 1
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self?.warningView.alpha = 0
                                self?.warningView.isHidden = true
                                self?.warningView.alpha = 1
                            }
                        }
                    }
                }),
            viewModel.convertPublisher
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { [weak self] result in
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            UIView.animate(withDuration: 0.5) {
                                self?.outputValueLabel.alpha = 0
                                self?.outputValueLabel.text = value
                                self?.outputValueLabel.alpha = 1
                            }
                        }
                    case .failure(let error):
                        let exceptionVC = ExceptionViewController.instantiated()
                        exceptionVC.error = error
                        self?.navigationController?.pushViewController(exceptionVC, animated: true)
                    }
                }),
            inputValuePublisher
                .combineLatest(inputSymbolPublisher, outputSymbolPublisher)
                .sink { [weak self] inputValue, inputSymbol, outputSymbol  in
                    self?.convertButton.isEnabled = !inputValue.isEmpty && !inputSymbol.isEmpty && !outputSymbol.isEmpty
                }
        ]
        viewModel.attachInputValueListener(inputValuePublisher)
        viewModel.attachInputSymbolListener(inputSymbolPublisher)
        viewModel.attachOutputSymbolListener(outputSymbolPublisher)
    }
}

//MARK: - UITextField methods
extension HomeViewController: UITextFieldDelegate {
    @objc private func dismissKeyboard(_ gesture: UIGestureRecognizer) {
        inputValueTxtField.resignFirstResponder()
        inputSymbolTxtField.resignFirstResponder()
        outputSymbolTxtField.resignFirstResponder()
    }
    
    @objc private func textFieldChanged(_ textField: UITextField) {
        if textField == inputValueTxtField {
            if let code = inputSymbolTxtField.text, let valueString = textField.text?.toCurrency(withCode: code) {
                textField.text = valueString
            }
        } else if textField == inputSymbolTxtField, let count = inputSymbolTxtField.text?.count, count >= 3 {
            inputValueTxtField.becomeFirstResponder()
        } else if textField == outputSymbolTxtField, let count = outputSymbolTxtField.text?.count, count >= 3 {
            outputSymbolTxtField.resignFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case inputValueTxtField:
            if let value = inputValueTxtField.text {
                inputValueSubject.send(value)
            }
        case inputSymbolTxtField:
            if let symbol = inputSymbolTxtField.text {
                inputSymbolSubject.send(symbol)
            }
        case outputSymbolTxtField:
            if let symbol = outputSymbolTxtField.text {
                outputSymbolSubject.send(symbol)
            }
        default:
            break
        }
    }
}
