//
//  AutoLayout.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 19/12/20.
//

import UIKit

@propertyWrapper final class AutoLayout<View: UIView> {
    
    let superView: UIView
    
    init(superView: UIView) {
        self.superView = superView
    }
    
    private lazy var view: View = {
        let view = View(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        superView.addSubview(view)
        return view
    }()

    var wrappedValue: View {
        return view
    }
}

