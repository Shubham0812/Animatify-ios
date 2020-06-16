//
//  CoreAnimations.swift
//  Animatify
//
//  Created by Shubham Singh on 15/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

/// CoreAnimation
enum LayerAnimationFactory {
    case strokeStart(duration: TimeInterval)
    case strokeEnd(duration: TimeInterval)
    
    func getAnimation() -> CABasicAnimation {
        switch self {
        case .strokeStart(let duration):
            let strokeStart = CABasicAnimation(keyPath: "strokeStart")
                strokeStart.duration = duration
                strokeStart.toValue = 1
                strokeStart.isRemovedOnCompletion = false
                strokeStart.fillMode = .forwards
                return strokeStart
            
        case .strokeEnd(let duration):
            let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
            strokeEnd.duration = duration
            strokeEnd.toValue = 1
            strokeEnd.isRemovedOnCompletion = false
            strokeEnd.fillMode = .forwards
            return strokeEnd
        }
    }
}
