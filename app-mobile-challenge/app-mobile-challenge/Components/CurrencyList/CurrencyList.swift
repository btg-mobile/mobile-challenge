//
//  CurrencyList.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

/// Protocolo de comunicação entre a `CurrencyList` e a `SupportedCurrenciesViewController`.
protocol CurrencyListService: class {
    func choiced(list: List)
}

/// Lista de moedas.
final class CurrencyList: UITableView {
    /// Conjunto de moedas do `CommonData`.
    private var lists = CommonData.shared.lists
    /// ViewModel rersponsável por essa classe.
    private lazy var viewModel =
        CurrencyListViewModel(lists: lists)
    /// Delegate de comunicação para a escolha de moedas.
    public weak var cdelegate: CurrencyListService?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configuração inicial.
    private func setUp() {
        self.delegate = self
        self.dataSource = self
        style()
        setUpViews()
    }
    
    /// Configuração das Views.
    private func setUpViews() {
        register()
        inicializeFavorites()
    }
    
    /// Configuração de aparencia.
    private func style() {
        separatorStyle = .none
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        sectionHeaderHeight = 42
        allowsSelection = true
    }
    
    /// Registro da `CurrencyListCell`
    private func register() {
        register(CurrencyListCell.self, forCellReuseIdentifier: CurrencyListCell.self.description())
    }
    
    /// Identificador de toque na escolha de Favoritos.
    /// - Parameter indexPath: Célula especifica de ao qual o favorito foi clicado.
    private func toggle(indexPath: IndexPath) {
        viewModel.toggleFavorite(indexPath: indexPath)
        reloadData()
    }
    
    /// Identificador de toque na escolha de uma Moeda.
    /// - Parameter indexPath: Célula especifica de ao qual o favorito foi clicado.
    private func selected(indexPath: IndexPath) {
        let list = viewModel.elementBy(indexPath: indexPath)
        cdelegate?.choiced(list: list)
    }
    
    
    /// Filtro de pesquisa.
    /// - Parameter textSearched: Texto que define a pesquisa.
    public func filterBy(textSearched: String) {
        viewModel.filterBy(textSearched: textSearched)
        reloadData()
    }
    /// Busca no `CommonData` por os favoritos e atualiza na tela.
    private func inicializeFavorites() {
        viewModel.inicializeFavorites()
        reloadData()
    }
}

// Em um projeto maiores esses componentes deveriam estar em componentes separados.
extension CurrencyList: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.elementsBy(section: section).count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: CurrencyListCell.self.description(), for: indexPath) as? CurrencyListCell else {
            return UITableViewCell()
        }
        let lists = viewModel.elementsBy(section: indexPath.section)
        cell.setUpComponent(currency: lists[indexPath.row],
                            indexPath: indexPath)
        cell.toggleAction = toggle
        cell.selectedAction = selected
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72 //configura o tamanho da celula
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.title(section: section)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white
            headerView.textLabel?.font = TextStyle.display3.font
            headerView.textLabel?.textColor = DesignSystem.Colors.secondary
        }
    }
}
