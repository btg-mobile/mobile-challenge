//
//  QuotaView.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 08/12/20.
//

import UIKit


class QuotaView: UIView {
    
    // Atributos
    private lazy var textFieldView: UITextView = {
        let textField = UITextView(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text =  String(valor) + " " + maincoin
        textField.delegate = self
        textField.textAlignment = .right
        textField.backgroundColor = .white
        textField.textColor = .lightGray
        
        return textField
    }()

    
    private lazy var buttonViewPlay: UIButton = {
        UIButton()
    }()
    
    private lazy var tableViewOrigin: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: quotaTableViewCellOriginID)
        tableView.delegate = delegates[0]
        delegates[0].view = self
        delegates[0].identifier = quotaTableViewCellOriginID
        delegates[0].didSelectItem = { index in
            
        }
        tableView.dataSource = dataSources[0]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(animationTableViewOrigin))
        tableView.addGestureRecognizer(tap)
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    private lazy var tableViewDestiny: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: quotaTableViewCellDestinyID)
        tableView.delegate = delegates[1]
        delegates[1].view = self
        delegates[1].identifier = quotaTableViewCellDestinyID
        delegates[1].didSelectItem = { index in
            
        }
        tableView.dataSource = dataSources[1]
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let tap = UITapGestureRecognizer(target: self, action: #selector(animationTableViewDestiny))
        tableView.addGestureRecognizer(tap)
        tableView.isUserInteractionEnabled = true
        tableView.isScrollEnabled = false
        
        return tableView
    }()
    
    private var valor: Float = 1.0
    
    private var maincoin: String = "EUA" {
        didSet {
            textFieldView.text = String(valor) + " " + maincoin
        }
    }
       
    private lazy var dataSources: [DataSource] = {
        [DataSource(coins: [], cellID: "QuotaTableViewtCellOrigin"),
        DataSource(coins: [], cellID: "QuotaTableViewtCellDestiny")]
    }()
    
    private lazy var delegates: [Delegate] = {
        [Delegate(),
        Delegate()]
    }()
    
    private var touch: Bool? = false
    
    var coinsType: [String]? = [] {
        didSet {
            guard let coins = coinsType else {
                return
            }
            dataSources[0].coins = coins
            dataSources[1].coins = coins
            DispatchQueue.main.async { [self] in
                tableViewOrigin.reloadData()
                tableViewDestiny.reloadData()
            }

        }
    }
    
    private let quotaTableViewCellOriginID = "QuotaTableViewtCellOrigin"
    private let quotaTableViewCellDestinyID = "QuotaTableViewtCellDestiny"
    
    // Construtor
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Métodos
    @objc func animationTableViewOrigin(_ heigth: CGFloat = 100) {
        for constraint in tableViewOrigin.constraints {
            if constraint.identifier == "heightAnchor" {
                if constraint.constant < 100 {
                    UIView.animate(withDuration: 0.5) { [self] in
                        constraint.constant += 100
                        tableViewOrigin.layoutIfNeeded()
                    }
                    tableViewOrigin.gestureRecognizers?.removeLast()
                    tableViewOrigin.isScrollEnabled = true
                } else {
                    UIView.animate(withDuration: 0.5) { [self] in
                        constraint.constant -= 100
                        tableViewOrigin.layoutIfNeeded()
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(animationTableViewOrigin))
                    tableViewOrigin.addGestureRecognizer(tap)
                    tableViewOrigin.isScrollEnabled = false
                }
            }
        }
    }
    
    @objc func animationTableViewDestiny(_ heigth: CGFloat = 100) {
        for constraint in tableViewDestiny.constraints {
            if constraint.identifier == "heightAnchor" {
                if constraint.constant < 100 {
                    UIView.animate(withDuration: 0.5) { [self] in
                        constraint.constant += 100
                        tableViewDestiny.layoutIfNeeded()
                    }
                    tableViewDestiny.gestureRecognizers?.removeLast()
                    tableViewDestiny.isScrollEnabled = true
                } else {
                    UIView.animate(withDuration: 0.5) { [self] in
                        constraint.constant -= 100
                        tableViewDestiny.layoutIfNeeded()
                    }
                    let tap = UITapGestureRecognizer(target: self, action: #selector(animationTableViewDestiny))
                    tableViewDestiny.addGestureRecognizer(tap)
                    tableViewDestiny.isScrollEnabled = false
                }
            }
        }
    }

}

// MARK: - ViewConding
extension QuotaView: ViewCodingProtocol {
    
    func buildViewHierarchy() {
        addSubview(textFieldView)
        addSubview(tableViewOrigin)
        addSubview(tableViewDestiny)
        
    }
    
    func setupConstraints() {
        
        
        // TextField
        textFieldView.topAnchor.constraint(equalTo: self.topAnchor, constant: 130).isActive = true
        textFieldView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        textFieldView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        textFieldView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                
        // TableViewOrigin
        tableViewOrigin.topAnchor.constraint(equalTo: self.textFieldView.bottomAnchor, constant: 30).isActive = true
        tableViewOrigin.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableViewOrigin.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        tableViewOrigin.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        let heightAnchorOrigin = tableViewOrigin.heightAnchor.constraint(equalToConstant: 70)
        heightAnchorOrigin.identifier = "heightAnchor"
        heightAnchorOrigin.isActive = true
        
        // TableViewOrigin
        tableViewDestiny.topAnchor.constraint(equalTo: self.tableViewOrigin.bottomAnchor, constant: 30).isActive = true
        tableViewDestiny.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        tableViewDestiny.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -50).isActive = true
        tableViewDestiny.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 50).isActive = true
        let heightAnchorDestiny = tableViewDestiny.heightAnchor.constraint(equalToConstant: 70)
        heightAnchorDestiny.identifier = "heightAnchor"
        heightAnchorDestiny.isActive = true
    }
    
}


// MARK: - UITextViewDelegate
extension QuotaView: UITextViewDelegate {
    
    
    func textViewDidChange(_ textView: UITextView) {
        textView.text = textView.text.replacingOccurrences(of: "\n", with: "")
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = String(valor) + " " + maincoin
            textView.textColor = UIColor.lightGray
        }
    }

}
