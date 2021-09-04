//
//  CoinTableCell.swift
//  CoinExchanger
//
//  Created by Junior on 03/09/21.
//

import UIKit

class CoinTableCell: UITableViewCell, ReusableView {
    // MARK: View
    let coinName: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Moderat-Medium", size: 20)
        label.textColor = Asset.Colors.text.color
        return label
    }()
    
    let coinID: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont(name: "Moderat-Regular", size: 16)
        label.textColor = Asset.Colors.gray.color
        return label
    }()
    
    // MARK: Override
    override func prepareForReuse() {
        coinName.text = ""
        coinID.text = ""
    }
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: Set
    func set(_ name: String?, _ id: String?) {
        coinName.text = name
        coinID.text = id
    }
    
    func set(_ coin: Coin?) {
        coinName.text = coin?.name
        coinID.text = coin?.cod
    }
}

private extension CoinTableCell {
    // MARK: Setup
    func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        imageView?.removeFromSuperview()
        textLabel?.removeFromSuperview()
        
        addSubview(coinName)
        coinName.top(equalTo: self, constant: Constants.space)
        coinName.fillHorizontal(to: self, constant: Constants.space)
        
        addSubview(coinID)
        coinID.topToBottom(of: coinName, constant: Constants.space/4)
        coinName.fillHorizontal(to: self, constant: Constants.space*2)
        coinName.bottom(equalTo: self, constant: -Constants.space)
    }
}
