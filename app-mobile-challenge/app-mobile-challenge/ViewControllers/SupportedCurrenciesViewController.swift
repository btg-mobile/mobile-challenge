//
//  SupportedCurrenciesViewController.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

class SupportedCurrenciesViewController: UIViewController {
    
    /// Botão de voltar
    @AutoLayout private var backButton: BackButtonView
    /// Título da página
    @AutoLayout private var titleLabel: TitleLabel
    
    /// Barra de pesquisa
    @AutoLayout private var search: Search
    /// Lista com as moedas
    @AutoLayout private var currentyList: CurrencyList

    private var viewModel: SupportedCurrenciesViewModel
    private var type: PickCurrencyType
    
    /// Inicializador da Supported
    /// - Parameters:
    ///   - viewModel: O `ViewModel` desse controller.
    ///   - type: Determina de onde o usuário veio e quais serão as ações da Controller.
    init(viewModel: SupportedCurrenciesViewModel, type: PickCurrencyType) {
        self.type = type
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        layoutViews()
        setUpDelegate()
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    //MARK: - Configuração inicial
    /// Realiza as especificações de cada view em tela.
    private func setUpViews() {
        setUpButton()
        setUpTitle()
        hideKeyboardWhenTappedAround() 
    }
    
    /// Configura as constraints dos elementos visuais.
    private func layoutViews() {
        layoutButton()
        layoutTitle()
        layoutSearch()
        layoutCurrentyList()
    }
    
    /// Configura a comunicação com os componentes
    private func setUpDelegate() {
        search.delegate = self
        currentyList.cdelegate = self
    }
    //MARK: - Final da configuração inicial
    
    //MARK: - Confuguração das Views
    private func setUpButton() {
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    /// Configura o título, tal como colocando a seu valor.
    private func setUpTitle() {
        titleLabel.text = viewModel.title()
    }
    //MARK: - Final da confuguração das Views
    
    //MARK: - Funções de objc.
    @objc private func back() {
        viewModel.back()
    }
    //MARK: - Final das funções de objc.
    
    //MARK: - Confuguração de Layout
    private func layoutButton() {
        view.addSubview(backButton)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            backButton.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: DesignSystem.Button.Back.height),
            backButton.widthAnchor.constraint(equalToConstant: DesignSystem.Button.Back.width)
        ])
    }
    
    private func layoutTitle() {
        view.addSubview(titleLabel)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutGuides.topAnchor, constant: DesignSystem.Spacing.large),
            titleLabel.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor)
        ])
    }
    
    private func layoutSearch() {
        view.addSubview(search)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            search.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: DesignSystem.Spacing.large*2),
            search.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            search.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor)
        ])
    }
    
    private func layoutCurrentyList() {
        view.addSubview(currentyList)
        
        let layoutGuides = view.layoutMarginsGuide

        NSLayoutConstraint.activate([
            currentyList.topAnchor.constraint(equalTo: search.bottomAnchor, constant: DesignSystem.Spacing.large),
            currentyList.bottomAnchor.constraint(equalTo: layoutGuides.bottomAnchor),
            currentyList.centerXAnchor.constraint(equalTo: layoutGuides.centerXAnchor),
            currentyList.widthAnchor.constraint(equalTo: layoutGuides.widthAnchor)
        ])
    }
    //MARK: - Final da confuguração de Layout
}

//MARK: - Crontrolar o recebimento de input
extension SupportedCurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        currentyList.filterBy(textSearched: textSearched)
    }
}

//MARK: - Crontrolar o recebimento de selecionar uma moeda
extension SupportedCurrenciesViewController: CurrencyListService {
    func choiced(currency: Currency) {
        viewModel.choiced(currency: currency, type: type)
    }
}
