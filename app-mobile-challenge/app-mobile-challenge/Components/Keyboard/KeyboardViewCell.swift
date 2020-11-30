//
//  KeyboardViewCell.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

/// Célula do `KeyboardView`
final class KeyboardViewCell: UICollectionViewCell {
    
    /// Imagem representativa do número no teclado.
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configuração da imagem da célula a patir do seu index.
    /// - Parameter index: valor correspondente a ordem da célula.
    public func setupComponent(index: Int) {
        let image = UIImage(named: "k-\(index)")
        imageView.image = image
        imageView.sizeToFit()
        self.backgroundColor = .white
    }
    
    /// Configuração das Views internas.
    private func setUpViews() {
        clipsToBounds = false
        layer.cornerRadius = frame.height/2
        layoutViews()
        setShadows()
    }
    
    /// Configuração das constraints da imagem central da célula.
    private func layoutViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    /// Configuração das sombras.
    private func setShadows() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 3
    }
}

