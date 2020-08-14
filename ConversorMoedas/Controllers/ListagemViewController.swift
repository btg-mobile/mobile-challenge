//
//  ListagemViewController.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

class ListagemViewController: UIViewController {

    @IBOutlet var collectionView : UICollectionView?
    
    var currencies: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        CurrenciesList().getList(callback: { list in
            self.currencies = list
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        })
    }
}

extension ListagemViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CurrencyCollectionViewCell
        let value = Array(currencies.values)[indexPath.item]
        cell?.setValue(value: value)
//        cell?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = presentingViewController as? CotacaoViewController
        vc?.setCurrency(currencies[indexPath.item])
        dismiss(animated: true, completion: nil)
    }
//    @objc func tap(_ sender: UITapGestureRecognizer) {
//
//        let location = sender.location(in: self.collectionView)
//        let indexPath = self.collectionView?.indexPathForItem(at: location)
//
//        if let index = indexPath {
//            print("index: \(index.item)!")
//       }
//    }
}

extension ListagemViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
}
