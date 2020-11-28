//
//  KeyboardView.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 28/11/20.
//

import UIKit

protocol KeyboardViewService: class {
    func selected(value: Int)
}

class KeyboardView: UICollectionView {
    private let layout = UICollectionViewFlowLayout()
    weak var kdelegate: KeyboardViewService?
    init(frame: CGRect, delegate: KeyboardViewService) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.kdelegate = delegate
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK - Funcs
    private func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isScrollEnabled = true
        register()
    }
    
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

extension KeyboardView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: DesignSystem.Keyboard.Cell.width, height: DesignSystem.Keyboard.Cell.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        kdelegate?.selected(value: convertValue(index: indexPath.row))
    }
    
    private func convertValue(index: Int) -> Int {
        var value: Int = 0
        switch index {
        case 0:
            value = 7
        case 1:
            value = 8
        case 2:
            value = 9
        case 3:
            value = 4
        case 4:
            value = 5
        case 5:
            value = 6
        case 6:
            value = 1
        case 7:
            value = 2
        case 8:
            value = 3
        case 9:
            value = 0
        default:
            value = index
        }
        return value
    }
}
