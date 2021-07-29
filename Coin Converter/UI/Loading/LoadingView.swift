//
//  LoadingView.swift
//  Coin Converter
//
//  Created by Igor Custodio on 28/07/21.
//

import UIKit

extension UIViewController {
    func showLoadingView() {
        let loadingView = LoadingView(frame: view.frame)
        view.addSubview(loadingView)
        navigationController?.navigationBar.layer.zPosition = -1;

    }
    
    func hideLoadingView() {
        if let loadingView = view.subviews.first(where: { $0 is LoadingView }) {
            loadingView.removeFromSuperview()
            navigationController?.navigationBar.layer.zPosition = 0;
        }
    }
}

extension UIView{
    func rotate() {
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
    }
}

class LoadingView: UIView {
    
    let backgroundView: UIView?
    
    override init(frame: CGRect) {
        let view = UIView(frame: frame)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.backgroundColor = .white
        backgroundView = view
        super.init(frame: frame)
        addSubview(view)
        addLoader()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLoader() {
        guard let view = backgroundView else { return }
        
        let imageView = UIImageView(image: UIImage(named: "loading"))
        
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        imageView.center = view.center
        
        view.addSubview(imageView)
        imageView.rotate()
    }
}
