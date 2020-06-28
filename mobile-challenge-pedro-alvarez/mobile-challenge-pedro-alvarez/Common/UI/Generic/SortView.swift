//
//  OrderingView.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

import UIKit

class SortView: UIView {
    
    private unowned var segmentedControl: UISegmentedControl
    
    private let idText = "Por código"
    private let fullNameText = "Por nome"
    
    init(frame: CGRect,
         segmentedControl: UISegmentedControl) {
        self.segmentedControl = segmentedControl
        super.init(frame: frame)
        applyViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SortView: ViewCodeProtocol {
    
    func buildHierarchy() {
        addSubview(segmentedControl)
    }
    
    func setupConstraints() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: segmentedControl,
                           attribute: .centerX,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .centerX,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: segmentedControl,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -30).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 180).isActive = true
    }
    
    func configureViews() {
        segmentedControl.insertSegment(withTitle: idText, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: fullNameText, at: 1, animated: true)
        segmentedControl.backgroundColor = .currencyTableViewCellBackgrouncColor
        segmentedControl.tintColor = .currencyTableViewCellLayerColor
        segmentedControl.selectedSegmentTintColor = .currencyTableViewCellLayerColor
        segmentedControl.selectedSegmentIndex = 0
    }
}
