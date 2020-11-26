//
//  ConvertView.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class ConvertView: UIView {
    
    let modelView = ConvertViewModel()
    
    let contentViewTounch:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        view.layer.zPosition = 0
        view.isUserInteractionEnabled = false
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let titleLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Conversão"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabelOrigin:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Moeda de Origem"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleLabelDestiny:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Moeda de destino"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Button for onboard mode
    let changeButtonOrigin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Trocar Moeda", for: .normal)
        button.backgroundColor = .white
        button.layer.zPosition = 3
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button for onboard mode
    let destinyButtonOrigin: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Trocar Moeda", for: .normal)
        button.backgroundColor = .white
        button.layer.zPosition = 3
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Button for onboard mode
    lazy var textInputOrigin: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Digite o Valor"
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.layer.zPosition = 3
        textField.keyboardType = .numberPad
        textField.returnKeyType = .route
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    /// Button for onboard mode
    let labelDestiny: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Resultado"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currencyOrigin:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Escolha Uma Moeda"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let currencyDestiny:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Escolha Uma Moeda"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Button for onboard mode
    let convertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Converter", for: .normal)
        button.backgroundColor = .white
        button.layer.zPosition = 3
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ConvertView:ViewCodable{
    func setupViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(titleLabelOrigin)
        self.addSubview(titleLabelDestiny)
        self.addSubview(changeButtonOrigin)
        self.addSubview(destinyButtonOrigin)
        self.addSubview(textInputOrigin)
        self.addSubview(labelDestiny)
        self.addSubview(currencyOrigin)
        self.addSubview(currencyDestiny)
        self.addSubview(convertButton)
        self.addSubview(contentViewTounch)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelOrigin.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 140),
            titleLabelOrigin.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            titleLabelDestiny.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -300),
            titleLabelDestiny.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            changeButtonOrigin.widthAnchor.constraint(equalToConstant: 110),
            changeButtonOrigin.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 140),
            changeButtonOrigin.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            destinyButtonOrigin.widthAnchor.constraint(equalToConstant: 110),
            destinyButtonOrigin.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -300),
            destinyButtonOrigin.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -20),
        ])
        
        NSLayoutConstraint.activate([
            textInputOrigin.heightAnchor.constraint(equalToConstant: 50),
            textInputOrigin.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            textInputOrigin.topAnchor.constraint(equalTo: titleLabelOrigin.bottomAnchor, constant: 50),
            textInputOrigin.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            labelDestiny.heightAnchor.constraint(equalToConstant: 50),
            labelDestiny.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.4),
            labelDestiny.topAnchor.constraint(equalTo: titleLabelDestiny.bottomAnchor, constant: 50),
            labelDestiny.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
        ])
        
        NSLayoutConstraint.activate([
            currencyOrigin.topAnchor.constraint(equalTo:  changeButtonOrigin.bottomAnchor, constant: 40),
            
            currencyOrigin.leadingAnchor.constraint(equalTo: textInputOrigin.trailingAnchor,constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            currencyDestiny.topAnchor.constraint(equalTo:  destinyButtonOrigin.bottomAnchor, constant: 50),
            
            currencyDestiny.leadingAnchor.constraint(equalTo: labelDestiny.trailingAnchor,constant: 30),
        ])
        
        NSLayoutConstraint.activate([
            convertButton.widthAnchor.constraint(equalToConstant: 100),
            convertButton.heightAnchor.constraint(equalToConstant: 40),
            convertButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -100),
            convertButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])

        
//        NSLayoutConstraint.activate([
//            contentViewTounch.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height),
//            contentViewTounch.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
//            contentViewTounch.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            contentViewTounch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//        ])
    }
    
    func setupAditionalConfiguration() {
        self.backgroundColor = .clear
    }
    
    /**
     simpleAlert create a simple alert
     - Authors: Mateus R.
     - Returns: nothing
     - Parameter titleController:String
     - Parameter messageController:String
     - Parameter titleAlert:String
     - Parameter completion:() -> Void
     */
    func simpleAlert(viewController:UIViewController,_ titleController: String,_ messageController:String,_ titleAlert:String){
        let alert = UIAlertAction(title: titleAlert, style: .default) { (UIAlertAction) in
            
        }
        let alertController = UIAlertController(title: titleController, message: messageController, preferredStyle: .alert)
        alertController.addAction(alert)
        
        viewController.present(alertController, animated: false, completion: nil)
    }
}

extension ConvertView:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        contentViewTounch.isUserInteractionEnabled = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contentViewTounch.isUserInteractionEnabled = false
    }
}

