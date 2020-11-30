//
//  KeyboardView.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

/// Protocolo de comunicação entre `KeyboardView` e a `CurrencyConverterViewController`
protocol KeyboardViewService: class {
    func selected(value: String)
}

/// View de Teclado, responsável por capturar os valores digitados.
final class KeyboardView: UICollectionView {
    /// Layout default da `UICollectionView`
    private let layout = UICollectionViewFlowLayout()
    /// Delegate responsável pela comunicação.
    weak var kdelegate: KeyboardViewService?
    /// `ViewModel` responsável por essa classe.
    private let viewModel = KeyboardViewModel()
    
    init(frame: CGRect, delegate: KeyboardViewService) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.kdelegate = delegate
        self.dataSource = self
        self.delegate = self
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configuração inicial.
    private func setUp() {
        contentInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        register()
    }
    
    /// Registro da `KeyboardViewCell`
    private func register() {
        register(KeyboardViewCell.self,
                 forCellWithReuseIdentifier: KeyboardViewCell.self.description())
    }
}

extension KeyboardView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: KeyboardViewCell.self.description(), for: indexPath) as? KeyboardViewCell else {
            return UICollectionViewCell()
        }
        cell.setupComponent(index: indexPath.row)
        return cell
    }
}

// Em um projeto maiores esses componentes deveriam estar em componentes separados.
extension KeyboardView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: DesignSystem.Keyboard.Cell.width, height: DesignSystem.Keyboard.Cell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        ImpactFeedback.run(style: .medium)
        let value = viewModel.convertValue(index: indexPath.row)
        kdelegate?.selected(value: value)
    }
}
