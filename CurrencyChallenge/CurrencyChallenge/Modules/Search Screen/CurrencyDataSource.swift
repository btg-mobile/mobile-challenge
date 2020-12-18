//
//  CurrencyDataSource.swift
//  CurrencyChallenge
//
//  Created by Higor Chaves Peres on 16/12/20.
//

import UIKit

let currencyCell : String = "currencyCell"

class CurrencyDataSource: NSObject, UICollectionViewDataSource{

    var currencies = [Currency]()

    let searchController : SearchCurrencyViewController
    
    init(controller: SearchCurrencyViewController) {
        self.searchController = controller
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if searchController.searching {
            return searchController.searchCurrencies.count
        }
        
        return currencies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: currencyCell, for: indexPath)
        
        if let currencyCell = cell as? CurrencyCollectionViewCell {
            
            if searchController.searching {
                currencyCell.initials.text = searchController.searchCurrencies[indexPath.row].abbreviation
                currencyCell.currencyName.text = searchController.searchCurrencies[indexPath.row].fullName
                return currencyCell
            }
            
            currencyCell.initials.text = currencies[indexPath.row].abbreviation
            currencyCell.currencyName.text = currencies[indexPath.row].fullName
            return currencyCell
        }
        
        return cell
    }
}
