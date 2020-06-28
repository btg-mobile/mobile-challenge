//
//  ErrorView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    
    var errorMessage: String {
        didSet {
            errorLbl.text = errorMessage
        }
    }
    
    private lazy var imageView: UIImageView = {
        return UIImageView(frame: .zero)
    }()
    
    private lazy var errorLbl: UILabel = {
        return UILabel(frame: .zero)
    }()
    
    init(frame: CGRect,
                  errorMessage: String) {
        self.errorMessage = errorMessage
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: ViewCodeProtocol {
    
    func buildHierarchy() {
        addSubview(imageView)
        addSubview(errorLbl)
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        
    }
}
