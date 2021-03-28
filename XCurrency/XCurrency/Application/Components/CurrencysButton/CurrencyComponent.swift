//
//  CurrencyComponent.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

class CurrencyComponent: UIView {

    // MARK: - Initialziers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

    // MARK: - Private Methods
    private func setup() {
        let nib = UINib(nibName: "CurrencyComponent", bundle: nil)
        let view: UIView = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = self.bounds
        self.addSubview(view)
    }
}
