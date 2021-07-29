//
//  ChooseCurrencyViewController.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import UIKit

protocol ChooseCurrencyDelegate {
    func didSelectedCurrency(_ currency: Currency, button: Int)
}

class ChooseCurrencyViewController: UIViewController {
    
    // MARK: - Variables
    private var tableView: UITableView!
    private var textField: UITextField!
    private var viewModel: ChooseCurrencyViewModelProtocol!
    private var button: Int!
    private var delegate: ChooseCurrencyDelegate!
    private var filter: String? = nil
    
    // MARK: - Initializers
    convenience init(viewModel: ChooseCurrencyViewModelProtocol, button: Int, delegate: ChooseCurrencyDelegate) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.button = button
        self.delegate = delegate
    }
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Navigation Controller settings
        navigationItem.title = Constants.chooseCurrencyTitle.rawValue
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Setup methods
    private func setupUI() {
        // View background
        view.backgroundColor = UIColor(hex: Colors.background.rawValue)
        hideKeyboardOnTap()
        setupTable()
        setupTextField()
        view.addSubview(tableView)
        view.addSubview(textField)
        let topText = NSLayoutConstraint(item: textField!, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 16)
        let leftText = NSLayoutConstraint(item: textField!, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 16)
        let rightText = NSLayoutConstraint(item: textField!, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: -16)
        let size = NSLayoutConstraint.setProperty(item: textField!, value: 40, attribute: .height)
        
        let topTable = NSLayoutConstraint(item: tableView!, attribute: .top, relatedBy: .equal, toItem: textField, attribute: .bottom, multiplier: 1, constant: 16)
        let leftTable = NSLayoutConstraint(item: tableView!, attribute: .left, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .left, multiplier: 1, constant: 0)
        let rightTable = NSLayoutConstraint(item: tableView!, attribute: .right, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .right, multiplier: 1, constant: 0)
        let bottomTable = NSLayoutConstraint(item: tableView!, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([
            topText, leftText, rightText, size,
            topTable, leftTable, rightTable, bottomTable
        ])
    }
    
    // MARK: - UI Elements
    private func setupTextField() {
        textField = UITextField()
        textField.delegate = self
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 16
        textField.addShadow()
        textField.placeholder = "Filtrar"
        textField.leftViewMode = .always
        textField.keyboardType = .default
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: textField.frame.height))
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftView?.layoutIfNeeded()
    }
    
    private func setupTable() {
        tableView = UITableView()
        tableView.separatorStyle = .none
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ChooseCurrencyTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier.rawValue)
        
        tableView.backgroundColor = .clear
    }
}

// MARK: - TextField delegate
extension ChooseCurrencyViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        filterText(textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        filterText(textField)
        return true
    }
    
    private func filterText(_ textField: UITextField) {
        guard let txt = textField.text else { return }
        if txt.count > 0 {
            filter = txt
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDelegate methods
extension ChooseCurrencyViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate.didSelectedCurrency(viewModel.getCurrencies(filter)[indexPath.row], button: button)
        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
}

// MARK: - UITableViewDatSource methods
extension ChooseCurrencyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCurrencies(filter).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier.rawValue, for: indexPath) as! ChooseCurrencyTableViewCell
        cell.currency = viewModel.getCurrencies(filter)[indexPath.row]
        return cell
    }
    
    
}
