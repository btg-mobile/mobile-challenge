//
//  ListagemViewController.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

class ListagemViewController: UIViewController, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet var collectionView : UICollectionView?
    
    var currencies: [CurrenciesList.Currencies] = []
    var searchCurrencies: [CurrenciesList.Currencies] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.dataSource = self
        collectionView?.delegate = self
        CurrenciesList().getList({ list in
            self.currencies = list.map {c in CurrenciesList.Currencies(key: c.key, value: c.value)}
            self.currencies = self.currencies.sorted(by: {a, b in a.key.localizedCaseInsensitiveCompare(b.key) == .orderedAscending})
            self.searchCurrencies = self.currencies
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }, {error in
            ExchangeViewController().showMessage("Erro", error as! String)
        })
    }
}

extension ListagemViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CurrencyCollectionViewCell
        
        let value = "\(currencies[indexPath.item].key) - \(currencies[indexPath.item].value)"
        cell?.setValue(value: value)
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = presentingViewController as? ExchangeViewController
        let key = currencies[indexPath.item].key
        let value = currencies[indexPath.item].value
        let tuple = (key: key, value: value)
        vc?.setCurrency(tuple)
        dismiss(animated: true, completion: nil)
    }
}

extension ListagemViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 30)
    }
    
}
