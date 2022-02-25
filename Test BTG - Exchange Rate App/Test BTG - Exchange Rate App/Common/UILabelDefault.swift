//
//  LabelDefault.swift
//  Test BTG - Exchange Rate App
// 
//  Created by Renan Marchini Andrusiac on 25/02/22
//  Copyright © 2017 Renan Marchini Andrusiac. All rights reserved.
//	

import UIKit

class UILabelDefault: UILabel {
    
    // MARK: - Init's

    init() {
        super.init(frame: .zero)
        
        self.font = UIFont(name: "Comfortaa-VariableFont_wght", size: 55)
        self.textColor = UIColor.themeDarkBlue
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
