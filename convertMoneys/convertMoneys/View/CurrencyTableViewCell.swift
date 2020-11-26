//
//  CurrencyTableViewCell.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {
    
    static let identifier:String = "Currency-Table-View-Cell"
    
    let currencyLabel:UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "R$"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(named: "colorText")
        label.layer.zPosition = 3
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}

//MARK: Constraints
extension CurrencyTableViewCell:ViewCodable{
    func setupViewHierarchy() {
        self.addSubview(currencyLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            currencyLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            currencyLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            currencyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            currencyLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
