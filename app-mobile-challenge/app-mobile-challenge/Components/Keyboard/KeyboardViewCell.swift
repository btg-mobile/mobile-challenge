//
//  KeyboardViewCell.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

class KeyboardViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupComponent(index: Int) {
        let image = UIImage(named: "k-\(index)")
        imageView.image = image
        imageView.sizeToFit()
        self.backgroundColor = .white
    }
    
    private func setUpViews() {
        clipsToBounds = false
        layer.cornerRadius = frame.height/2
        layoutViews()
        setShadows()
    }
    
    private func layoutViews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setShadows() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
}

