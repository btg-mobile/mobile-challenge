//
//  BtgLabelLarge.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class BtgLabelLarge: BtgLabel {

    override init() {
        super.init()
        
        textColor = .darkGray
        if let font = UIFont.btgLabelLarge() {
            self.font = font
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}
