//
//  CurrencyListCell.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

final class CurrencyListCell: UITableViewCell {
    
    @AutoLayout private var starButton: UIButton
    @AutoLayout private var codeLabel: TitleLabel
    @AutoLayout private var nameLabel: SubtitleLabel
    private var currency: Currency?
    private var indexPath = IndexPath()
    
    var toggleAction: ((_ index: IndexPath)->Void)? = nil

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
        setUpButton()
    }
    
    private func layoutViews() {
        layoutButton()
        layoutTitle()
        layoutSubtitle()
    }
    //MARK:- Final da configuração inicial
    
    //MARK:- Funções
    public func setUpComponent(currency: Currency,
                               indexPath: IndexPath) {
        self.indexPath = indexPath
        self.currency = currency
        codeLabel.text = currency.code
        codeLabel.font = TextStyle.display4.font
        nameLabel.text = currency.name
        setUpStar(favorite: currency.favorite)
        self.backgroundColor = .white
    }
    private func setUpButton() {
        starButton.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
        starButton.layer.cornerRadius = 14
        starButton.clipsToBounds = true
    }
    private func setUpStar(favorite: Bool?) {
        if favorite ?? false {
            starButton.setImage(DesignSystem.Icons.star_fill, for: .normal)
        } else {
            starButton.setImage(DesignSystem.Icons.star, for: .normal)
        }
    }
    private func toggle() {
        currency?.favorite.toggle()
//        setUpStar(favorite: currency?.favorite)
        toggleAction?(indexPath)
    }
    //MARK:- Final das funções
    
    //MARK:- Funcões objs
    
    //MARK:- Final de funcões objs
    
    //MARK:- Configuração do Style
    private func style() {
        frame = frame.offsetBy(dx: 10, dy: 10)
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
        selectionStyle = .none
    }
    //MARK:- Final da configuração do Style
    
    //MARK:- Configuração do Layout
    private func layoutButton() {
        addSubview(starButton)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            starButton.centerYAnchor.constraint(equalTo: layoutGuides.centerYAnchor),
            starButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            starButton.widthAnchor.constraint(equalToConstant: 48),
            starButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    private func layoutTitle() {
        addSubview(codeLabel)
        let layoutGuides = layoutMarginsGuide

        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.default),
            codeLabel.leadingAnchor.constraint(equalTo: starButton.trailingAnchor, constant: DesignSystem.Spacing.default)
        ])
    }
    private func layoutSubtitle() {
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: codeLabel.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: starButton.trailingAnchor, constant: DesignSystem.Spacing.default)
        ])
    }
    //MARK:- Final da configuração do Layout
    
    /// Reconhecimento de toque nos favoritos
        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, starButton.bounds.contains(touch.location(in: self)) {
            toggle()
        }
    }
}
