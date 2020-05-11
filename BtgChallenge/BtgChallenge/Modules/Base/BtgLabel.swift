//
//  BtgLabel.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 11/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class BtgLabel: UILabel {

    init() {
        super.init(frame: .zero)
        
        textColor = .darkGray
        if let font = UIFont.btgLabelSmall() {
            self.font = font
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
