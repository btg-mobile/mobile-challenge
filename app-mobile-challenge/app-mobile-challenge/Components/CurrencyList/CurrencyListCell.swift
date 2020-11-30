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
    private var currency: List?
    private var indexPath = IndexPath()
    
    var toggleAction: ((_ index: IndexPath)->Void)? = nil
    var selectedAction: ((_ index: IndexPath)->Void)? = nil
    
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
    public func setUpComponent(currency: List,
                               indexPath: IndexPath) {
        self.indexPath = indexPath
        self.currency = currency
        codeLabel.text = currency.code
        codeLabel.font = TextStyle.display4.font
        nameLabel.text = currency.name
        setUpStar(favorite: currency.favorite)
        self.backgroundColor = .white
        if isCellSelected() { isSelected = true }
    }
    override var isSelected: Bool {
        didSet {
            alpha = isSelected ? 0.5 : 1.0
        }
    }
    private func setUpButton() {
        starButton.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.968627451, blue: 0.9803921569, alpha: 1)
        starButton.layer.cornerRadius = 14
        starButton.clipsToBounds = true
    }
    /// Configura qual imagem vai aparecer parar a estrela.
    /// - Parameter favorite: Em caso do valor verdade ele colocará na imagem a preencida no `starButton`, caso contrárrio a sem preenchimento.
    private func setUpStar(favorite: Bool?) {
        if favorite ?? false {
            starButton.setImage(DesignSystem.Icons.star_fill, for: .normal)
        } else {
            starButton.setImage(DesignSystem.Icons.star, for: .normal)
        }
    }
    /// Faz a chamada quando um botão de favorito é clicado.
    private func toggle() {
        toggleAction?(indexPath)
    }
    /// Faz a chamada quando uma célula é cliicada.
    private func selected() {
        selectedAction?(indexPath)
    }
    /// Verifica pelo tipo de ação da controller para qual moeda é a chamada.
    /// - Parameter type: Tipo de ação da controler, determindo pelo enumerador `PickCurrencyType`
    /// - Returns: Caso o tipo seja encontrado a função retornará o `code` dela, caso contrário retornará `nil`
    private func getCurrencyCodeSelected(type: String) -> String? {
        var value = ""
        switch type {
        case "from":
            value = CommonData.shared.fromCurrencyStorage
        case "to":
            value = CommonData.shared.toCurrencyStorage
        default:
            return nil
        }
        return value
    }
    /// Verifica se a celula foi selecionada na tela prrincipal.
    /// - Returns: Retorna `true`, caso verdadeiro e `false`, caso contrário.
    private func isCellSelected() -> Bool {
        let type = CommonData.shared.selectedTypeCurrency
        guard let code = getCurrencyCodeSelected(type: type) else { return false }
        return currency?.code == code
    }
    //MARK:- Final das funções
    
    //MARK:- Configuração do Style
    private func style() {
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
    
    /// Reconhecimento de toque
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if starButton.bounds
                .contains(touch.location(in: self)) {
                //Identifica toque nos favoritos.
                toggle()
            } else if self.bounds
                        .contains(touch.location(in: self)) {
                //Identifica toque na célula.
                selected()
            }
        }
    }
}
