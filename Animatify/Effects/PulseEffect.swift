//
//  PulseEffect.swift
//  Animatify
//
//  Created by Shubham Singh on 14/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class PulseLayer: CALayer {
    
    var animationGroup = CAAnimationGroup()
    
    var initialPulse: Float = 0.0
    var nextPulseAfter: TimeInterval = 0.2
    var animationDuration: TimeInterval = 1
    var radius: CGFloat = 0
    
    
    // MARK:- initializers for the CALayer
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Initializer for the PulseLayer
    /// radius - determines the  radius of the pulse
    /// view - the view where the effect will be added
    /// color - the color for the pulse
    init(radius: CGFloat, for view: UIView, with color: UIColor) {
        super.init()
        
        self.backgroundColor = color.cgColor
        self.contentsScale = UIScreen.main.scale
        
        self.opacity = 0
        self.radius = radius
        self.position = view.center
        
        self.bounds = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        self.cornerRadius = radius
        
        // set the animationGroup and start the animation
        DispatchQueue.main.async {
            self.setupAnimationGroup()
            self.add(self.animationGroup, forKey: "pulse")
        }
    }
    
    // MARK:- functions for the CALayer
    func createScaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: initialPulse)
        scaleAnimation.toValue = 1
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnimation.duration = animationDuration
        
        opacityAnimation.values = [0.4, 0.8, 0]
        opacityAnimation.keyTimes = [0, 0.4, 1]
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup = CAAnimationGroup()
        self.animationGroup.duration = self.animationDuration + self.nextPulseAfter
        self.animationGroup.repeatCount = .infinity
        
        self.animationGroup.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.animationGroup.animations = [self.createScaleAnimation(), self.createOpacityAnimation()]
    }
}
