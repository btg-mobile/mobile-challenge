//
//  ChooseCurrencyTableViewCell.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import UIKit

class ChooseCurrencyTableViewCell: UITableViewCell {

    // MARK: - Variables
    var currency: Currency? {
        didSet {
            guard let currency = self.currency else { return }
            initials.text = currency.initials
            expanded.text = currency.extendedName
        }
    }
    
    private var initials: UILabel!
    private var expanded: UILabel!
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initials = UILabel.createLabel(text: "", properties: UILabelProperties(alignment: .right, color: .black, size: 14))
        
        expanded = UILabel.createLabel(text: "", properties: UILabelProperties(alignment: nil, color: .init(hex: "#707070"), size: 12))
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addMainStackView()
    }
    
    // MARK: - UI Elements
    private func addMainStackView() {
        let stackView = UIStackView(arrangedSubviews: [
            initials, expanded
        ])
        
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.alignment = .center
        
        stackView.addShadow()
        stackView.backgroundColor = .white
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([NSLayoutConstraint.setProperty(item: initials!, value: 48, attribute: .width)])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = NSLayoutConstraint.setConstraintEqualParent(item: stackView, parent: self, margin: (top: 0, right: -24, bottom: -16, left: 24))
        NSLayoutConstraint.activate(constraints)
    }

}
