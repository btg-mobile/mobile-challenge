//
//  StateTransition.swift
//  CurrencyConverter
//
//  Created by Breno Aquino on 01/11/20.
//

import UIKit

extension UIView {
    static let customViewTag: Int = 9327
}

protocol StateTransition: class {
    
    var loadingView: UIView { get }
    var referenceView: UIView { get }
    
    func loading(animated: Bool)
    func content(animated: Bool)
    func custom(view: UIView, animated: Bool)
}

extension StateTransition {
    private func showView(_ view: UIView, animated: Bool) {
        referenceView.addSubview(view)
        view
            .top(anchor: referenceView.topAnchor)
            .leading(anchor: referenceView.leadingAnchor)
            .trailing(anchor: referenceView.trailingAnchor)
            .bottom(anchor: referenceView.bottomAnchor)
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                view.alpha = 1
            }
        } else {
            view.alpha = 1
        }
    }
    
    func loading(animated: Bool = true) {
        loadingView.useConstraint()
        loadingView.alpha = 0
        showView(loadingView, animated: animated)
    }
    
    func custom(view: UIView, animated: Bool = true) {
        view.tag = UIView.customViewTag
        view.useConstraint()
        view.alpha = 0
        showView(view, animated: animated)
    }
    
    func content(animated: Bool = true) {
        let customView = referenceView.subviews.first(where: { $0.tag == UIView.customViewTag })
        if animated {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.loadingView.alpha = 0
                customView?.alpha = 0
            }, completion: { [weak self] _ in
                self?.loadingView.removeFromSuperview()
                customView?.removeFromSuperview()
            })
        } else {
            loadingView.removeFromSuperview()
            customView?.removeFromSuperview()
        }
    }
}

extension StateTransition where Self: UIView {
    var referenceView: UIView {
        return self
    }
}

extension StateTransition where Self: UIViewController {
    var referenceView: UIView {
        return view
    }
}
