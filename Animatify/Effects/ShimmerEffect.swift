//
//  ShimmerEffect.swift
//  Animatify
//
//  Created by Shubham Singh on 20/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class ShimmerLayer: CAGradientLayer {
    
    // MARK:- initializers for the CALayer
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Initializer for the PulseLayer
    /// view - the view where the effect will be added
    /// cornerRadius - determines the  cornerRadius of the gradientLayer
    init(for view: UIView,cornerRadius: CGFloat) {
        super.init()
        let gradientColorOne = UIColor.systemGray.withAlphaComponent(0.9).cgColor
        let gradientColorTwo = UIColor.systemGray.withAlphaComponent(0.75).cgColor
        
        self.frame = view.bounds
        self.startPoint = CGPoint(x: 0.0, y: 1.0)
        self.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        self.locations = [0.0, 0.5, 1.0]
        self.position = view.center
        self.cornerRadius = cornerRadius
    }
    
    
    // MARK:- function for the CAGradientLayer
    func startAnimation() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 0.7
        self.add(animation, forKey: animation.keyPath)
    }
    
    func removeAnimation(){
        self.removeAllAnimations()
    }
    
    
}
