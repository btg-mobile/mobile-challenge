//
//  ViewController.swift
//  mobileChallenge
//
//  Created by Henrique on 03/02/25.
//

import UIKit

class HomeController: UIViewController, CurrencyListProtocol {
    
    private let viewModel: HomeControllerViewModel
    let textFieldDelegate = TextFieldDelegate()
    
    init (viewModel: HomeControllerViewModel = HomeControllerViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let msgLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading Currencies..."
        label.font = UIFont.systemFont(ofSize: 32)
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let txtField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Insira o valor para converter"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let firstCurrencyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("BRL", for: .normal)
        btn.setTitleColor(.link, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return btn
    }()
    
    let convertedLabel: UILabel = {
        let label = UILabel()
        label.text = "0.00"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.layer.borderColor = UIColor.lightGray.cgColor
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        return label
    }()
    
    let secondCurrencyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("USD", for: .normal)
        btn.setTitleColor(.link, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return btn
    }()
    
    let invertCurrencyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
        return btn
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchAPI()
        setuptxtField()
        setupFirstCurrencyBtn()
        setupConvertedLabel()
        setupSecondCurrencyBtn()
        setupInvertCurrencyBtn()
        setupMsgTxt()
        self.view.backgroundColor = .white
        self.viewModel.onCurrencyUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.msgLabel.isHidden = true
                print("api loaded")
            }
        }
        self.viewModel.onErrorMessage = { [weak self] error in
            DispatchQueue.main.async {
                self?.msgLabel.text = error.localizedDescription
            }
        }
        textFieldDelegate.onCalculatedValue = { [weak self] value in
            self?.convertedLabel.text = String(value)
        }
    }
    
    func setuptxtField(){
        view.addSubview(txtField)
        textFieldDelegate.updateViewModel(viewmodel: viewModel)
        txtField.delegate = textFieldDelegate
        NSLayoutConstraint.activate([
            txtField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            txtField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
        ])
    }
    
    
    func setupFirstCurrencyBtn(){
        view.addSubview(firstCurrencyBtn)
        firstCurrencyBtn.addTarget(self, action: #selector(firstCurrencyBtnTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            firstCurrencyBtn.centerYAnchor.constraint(equalTo: txtField.centerYAnchor),
            firstCurrencyBtn.leadingAnchor.constraint(equalTo: txtField.trailingAnchor, constant: 10),
            firstCurrencyBtn.heightAnchor.constraint(equalTo: txtField.heightAnchor)
        ])
    }
    
    func setupConvertedLabel(){
        view.addSubview(convertedLabel)
        NSLayoutConstraint.activate([
            convertedLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50),
            convertedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -20),
            convertedLabel.heightAnchor.constraint(equalTo: txtField.heightAnchor),
            convertedLabel.widthAnchor.constraint(equalTo: txtField.widthAnchor)
        ])
    }
    
    func setupSecondCurrencyBtn(){
        view.addSubview(secondCurrencyBtn)
        secondCurrencyBtn.addTarget(self, action: #selector(secondCurrencyBtnTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            secondCurrencyBtn.centerYAnchor.constraint(equalTo: convertedLabel.centerYAnchor),
            secondCurrencyBtn.leadingAnchor.constraint(equalTo: convertedLabel.trailingAnchor, constant: 10),
            secondCurrencyBtn.heightAnchor.constraint(equalTo: convertedLabel.heightAnchor)
        ])
    }
    
    func setupInvertCurrencyBtn(){
        view.addSubview(invertCurrencyBtn)
        invertCurrencyBtn.addTarget(self, action: #selector(swapBtnTap), for: .touchUpInside)
        NSLayoutConstraint.activate([
            invertCurrencyBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            invertCurrencyBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupMsgTxt(){
        view.addSubview(msgLabel)
        NSLayoutConstraint.activate([
            msgLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            msgLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            msgLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            msgLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc func firstCurrencyBtnTap(){
        let vc = CurrencyListController(homeControllerViewModel: viewModel)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func secondCurrencyBtnTap(){
        let vc = CurrencyListController(homeControllerViewModel: viewModel, selected: 2)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func swapBtnTap(){
        invertCurrencyBtn.isEnabled = false
        let sec = firstCurrencyBtn.titleLabel?.text
        firstCurrencyBtn.setTitle(secondCurrencyBtn.currentTitle, for: .normal)
        secondCurrencyBtn.setTitle(sec, for: .normal)
        viewModel.invertCurrencies()
        convertedLabel.text = String(viewModel.calculateConversion(value: Double(txtField.text ?? "0.00") ?? 0.00))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            self.invertCurrencyBtn.isEnabled = true
        }
    }
    
    func selectedCurrency(code: String, selected: Int) {
        if selected == 1{
            firstCurrencyBtn.setTitle(code, for: .normal)
        } else {
            secondCurrencyBtn.setTitle(code, for: .normal)
        }
        convertedLabel.text = String(viewModel.calculateConversion(value: Double(txtField.text ?? "0.00") ?? 0.00))
    }
}

