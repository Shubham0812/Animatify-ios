//
//  CoreAnimations.swift
//  Animatify
//
//  Created by Shubham Singh on 15/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit
/// CoreAnimations
enum LayerAnimationFactory {
    static func getStrokeStartAnimation(duration: TimeInterval, toValue: CGFloat = 1.0) -> CABasicAnimation {
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.duration = duration
        strokeStart.toValue = toValue
        strokeStart.isRemovedOnCompletion = false
        strokeStart.fillMode = .forwards
        return strokeStart
    }
    
    static func getStrokeEndAnimation(duration: TimeInterval, toValue: CGFloat = 1.0, isRemovedOnCompletion : Bool = false) -> CABasicAnimation {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.duration = duration
        strokeEnd.toValue = toValue
        strokeEnd.isRemovedOnCompletion = isRemovedOnCompletion
        strokeEnd.fillMode = .forwards
        return strokeEnd
    }
    
    static func getPulsatingAnimation(duration: TimeInterval, toValue: CGFloat = 1.5) -> CABasicAnimation {
        let pulse = CABasicAnimation(keyPath: "transform.scale")
        pulse.duration = duration
        pulse.toValue = toValue
        pulse.timingFunction=CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        pulse.autoreverses=true
        pulse.repeatCount = .infinity
        return pulse
    }
}
