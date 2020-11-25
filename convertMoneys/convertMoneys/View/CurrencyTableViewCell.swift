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
    
    init() {
        super.init(style: .default, reuseIdentifier: CurrencyTableViewCell.identifier)
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
            currencyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            currencyLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
