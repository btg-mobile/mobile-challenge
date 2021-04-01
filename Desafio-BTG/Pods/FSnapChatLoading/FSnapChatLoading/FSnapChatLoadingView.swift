//
//  FSLoadingView.swift
//  Created by Mac on ١٩‏/١٠‏/٢٠١٨.
//  Copyright © ٢٠١٨ Faisal AL-Otaibi. All rights reserved.
//

import UIKit

public enum LoadingType {
    case large
    case small
}

open class FSnapChatLoadingView: UIView {
    
    
    var overlayView:UIView!
    
    public var colorBackground:UIColor = .clear
    
    public var isBlurEffect = true
    
    public var loadingType: LoadingType = .large
    
    public var duration:Double = 1
    
    public func show(view:UIView?,color:UIColor = UIColor.red) {
        self.frame = view!.frame
        self.backgroundColor = UIColor.clear
        overlayView = UIView()
        overlayView.frame = view!.frame
        overlayView.backgroundColor = colorBackground
        
        if isBlurEffect {
            let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            overlayView.addSubview(blurEffectView)
        }
        
        var size:CGFloat = 90
        var lineWidth:CGFloat = 3
        
        switch loadingType {
        case .large:
            size = 90
            lineWidth = 3
        case .small:
            size = 75
            lineWidth = 2
        }
        
        let loading = FSLoading(frame: CGRect(x: view!.center.x - (size/2), y: view!.center.y - (size/2), width: size, height: size))
        loading.duration = duration
        loading.lineWidth = lineWidth
        loading.setup(color: color)
        overlayView.addSubview(loading)
        
        view!.addSubview(overlayView)
    }
    
    public func hide() {
        if overlayView != nil {
            overlayView.removeFromSuperview()
        }
    }
    
    public func setColorBackground(color:UIColor){
        colorBackground = color
    }
    
    public func setBackgroundBlurEffect(){
        isBlurEffect = true
    }
    
}
