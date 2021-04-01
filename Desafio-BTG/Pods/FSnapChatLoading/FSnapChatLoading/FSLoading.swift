//
//  FSLoading.swift
//  Created by Mac on ١٩‏/١٠‏/٢٠١٨.
//  Copyright © ٢٠١٨ Faisal AL-Otaibi. All rights reserved.
//

import UIKit

class FSLoading: UIView {
    
    
    public var color:UIColor = UIColor.red
    public var lineWidth:CGFloat = 3
    public var duration:Double = 1
    
    lazy var bView: UIView = {
        let bView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        bView.backgroundColor = UIColor.clear
        setAnimation(view: bView, isReturn: false)
        setLayer(view: bView)
        return bView
    }()
    
    
    lazy var sView: UIView = {
        let sView = UIView(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height - 20))
        sView.backgroundColor = UIColor.clear
        setAnimation(view: sView, isReturn: true)
        setLayer(view: sView)
        return sView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
        
    }
    
    func setup(color:UIColor) {
        self.color = color
        addSubview(bView)
        addSubview(sView)
    }
    
    func setAnimation(view:UIView,isReturn:Bool) {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        if isReturn {
            rotation.toValue = -Double.pi * 2
        }else{
            rotation.toValue = Double.pi * 2
        }
        rotation.duration = duration
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        view.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    func setLayer(view:UIView) {
        
        let layerView = CAShapeLayer()
        
        let path = UIBezierPath()
        
        let radius: Double = Double(view.frame.width) / 2 - 20
        
        let center = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        
        path.move(to: CGPoint(x: center.x + CGFloat(radius), y: center.y))
        
        for i in stride(from: 0, to: 220.0, by: 1) {
            // radians = degrees * PI / 180
            let radians = i * Double.pi / 180
            
            let x = Double(center.x) + radius * cos(radians)
            let y = Double(center.y) + radius * sin(radians)
            
            path.addLine(to: CGPoint(x: x , y: y))
        }
        
        layerView.path = path.cgPath
        layerView.fillColor = UIColor.clear.cgColor
        layerView.lineWidth = lineWidth
        layerView.strokeColor = color.cgColor
        view.layer.addSublayer(layerView)
        
    }
    
}
