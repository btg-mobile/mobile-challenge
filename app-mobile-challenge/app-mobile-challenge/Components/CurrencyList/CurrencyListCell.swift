//
//  CurrencyListCell.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyListCell: UITableViewCell {
    
    @AutoLayout private var starImage: UIImageView
    @AutoLayout private var codeLabel: TitleLabel
    @AutoLayout private var nameLabel: SubtitleLabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        layoutViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:- Configuração inicial
    private func setUpViews() {
        style()
        setUpImage()
    }
    
    private func layoutViews() {
        layoutImage()
        layoutTitle()
        layoutSubtitle()
    }
    //MARK:- Final da configuração inicial
    
    //MARK:- Funções
    public func setUpComponent(currency: Currency) {
        codeLabel.text = currency.code
        codeLabel.font = TextStyle.display4.font
        nameLabel.text = currency.name
        self.backgroundColor = .white
    }
    private func setUpImage() {
        starImage.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
        let icon = DesignSystem.Icons.star
        
        starImage.image = icon
        starImage.layer.cornerRadius = 14
        starImage.clipsToBounds = true
    }
    //MARK:- Final das funções
    
    //MARK:- Configuração do Style
    private func style() {
        frame = frame.offsetBy(dx: 10, dy: 10)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
    //MARK:- Final da configuração do Style
    
    //MARK:- Configuração do Layout
    private func layoutImage() {
        addSubview(starImage)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            starImage.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            starImage.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 48),
            starImage.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    private func layoutTitle() {
        addSubview(codeLabel)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.default),
            codeLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: DesignSystem.Spacing.default)
        ])
    }
    private func layoutSubtitle() {
        addSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: starImage.trailingAnchor, constant: DesignSystem.Spacing.default)
        ])
    }
    
    //MARK:- Final da configuração do Layout
}
