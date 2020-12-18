//
//  CurrenciesCollectionViewDelegate.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import UIKit

class CurrenciesCollectionViewDelegate: NSObject, UICollectionViewDelegate {
    
    let searchController : SearchCurrencyViewController
    
    init(controller: SearchCurrencyViewController) {
        self.searchController = controller
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if searchController.searching {
            searchController.delegate?.selectedCurrency(searchController.searchCurrencies[indexPath.row])
        }else{
            searchController.delegate?.selectedCurrency(searchController.modelController.currencies[indexPath.row])
        }
        
        searchController.dismiss(animated: true)
    }
   
}
