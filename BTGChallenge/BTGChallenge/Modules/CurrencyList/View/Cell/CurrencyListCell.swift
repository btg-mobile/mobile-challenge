//
//  CurrencyListCell.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 11/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit


class CurrencyList: NibView {
    
    @IBOutlet weak var currencyCodeLbl: UILabel!
    @IBOutlet weak var currencyNameLbl: UILabel!
    
    required init(with data: CurrencyListViewData) {
        super.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.setLabels(data: data)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabels(data: CurrencyListViewData) {
        self.currencyCodeLbl.text = data.currencyCode
        self.currencyNameLbl.text = data.currencyName
    }
    
}
