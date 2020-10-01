//
//  AutoLayout.swift
//  btg-mobile-challenge
//
//  Created by Artur Carneiro on 01/10/20.
//

import UIKit

@propertyWrapper final class AutoLayout<View: UIView> {
    private lazy var view: View = {
        let view = View(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    var wrappedValue: View {
        return view
    }
}
