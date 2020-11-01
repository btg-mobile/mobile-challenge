//
//  StateTransition.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 01/11/20.
//

import UIKit

protocol StateTransition: class {
    var loadingView: UIView { get }
    
    func loading(animated: Bool)
    func content(animated: Bool)
}

extension StateTransition {
    func content(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.loadingView.alpha = 0
            }, completion: { [weak self] _ in
                self?.loadingView.removeFromSuperview()
            })
        } else {
            loadingView.removeFromSuperview()
        }
    }
}

extension StateTransition where Self: UIView {
    
    func loading(animated: Bool = true) {
        loadingView.useConstraint()
        loadingView.alpha = 0
        
        addSubview(loadingView)
        loadingView
            .top(anchor: topAnchor)
            .leading(anchor: leadingAnchor)
            .trailing(anchor: trailingAnchor)
            .bottom(anchor: bottomAnchor)
        
        if animated {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.loadingView.alpha = 1
            }
        } else {
            loadingView.alpha = 1
        }
    }
}

extension StateTransition where Self: UIViewController {
    
    func loading(animated: Bool = true) {
        loadingView.useConstraint()
        loadingView.alpha = 0
        
        view.addSubview(loadingView)
        loadingView
            .top(anchor: view.topAnchor)
            .leading(anchor: view.leadingAnchor)
            .trailing(anchor: view.trailingAnchor)
            .bottom(anchor: view.bottomAnchor)
        
        if animated {
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.loadingView.alpha = 1
            }
        } else {
            loadingView.alpha = 1
        }
    }
}
