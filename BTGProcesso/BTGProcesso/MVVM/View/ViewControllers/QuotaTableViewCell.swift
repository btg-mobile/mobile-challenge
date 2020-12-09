//
//  QuotaTableViewCell.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 08/12/20.
//

import UIKit

class QuotaTableViewCell: UITableViewCell {
    
    // Atributos
    lazy var textLabelView: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - ViewConding
extension QuotaTableViewCell: ViewCodingProtocol {
    
    func buildViewHierarchy() {
        addSubview(textLabelView)
    }
    
    func setupConstraints() {
        textLabelView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabelView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textLabelView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    
}

class QuotaTableViewCellDestiny: UITableViewCell {
    
    // Atributos
    lazy var textLabelView: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - ViewConding
extension QuotaTableViewCellDestiny: ViewCodingProtocol {
    
    func buildViewHierarchy() {
        addSubview(textLabelView)
    }
    
    func setupConstraints() {
        textLabelView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabelView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabelView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textLabelView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    
    
}
