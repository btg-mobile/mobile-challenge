//
//  CurrencyListTableViewCell.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class CurrencyListTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    private lazy var currencyLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    private lazy var footerView: UIView = {
        return UIView(frame: .zero)
    }()
    
    private(set) var currencyAttrString: NSAttributedString?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(currencyAttrString: NSAttributedString) {
        self.currencyAttrString = currencyAttrString
        applyViewCode()
    }
}

extension CurrencyListTableViewCell: ViewCodeProtocol {
    
    func buildHierarchy() {
        containerView.addSubview(currencyLbl)
        addSubview(containerView)
        addSubview(footerView)
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        containerView.layer.cornerRadius = 4
        containerView.layer.borderColor = UIColor.currencyTableViewCellLayerColor.cgColor
        containerView.layer.borderWidth = 1
        containerView.backgroundColor = UIColor.currencyButtonBackgroundColor
        currencyLbl.textColor = UIColor.currencyLblColor
        backgroundColor = UIColor.currencyTableViewCellBackgrouncColor
        currencyLbl.attributedText = currencyAttrString
    }
}
