//
//  LogoAnimation.swift
//  Animatify
//
//  Created by Shubham Singh on 15/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation
import UIKit

protocol CoreAnimationDelegate {
    func animationFinished()
}

final class LogoLayer: CAShapeLayer, CAAnimationDelegate {
    
    var lineW: CGFloat = 0
    var logoFrame: CGRect = CGRect()
    var scaleFactor: CGFloat = 1
    var animationDuration: TimeInterval = 0
    
    var trackColor = UIColor()
    var glideColor = UIColor()
    var fillingColor = UIColor()
    
    var logoLayer = CAShapeLayer()
    var glideLayer = CAShapeLayer()
    var fillLayer = CAShapeLayer()
    
    var sliderFinished = false
    var coreAnimationDelegate: CoreAnimationDelegate?
    
    // MARK:- initializers for the CALayer
    override init() {
        super.init()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    /// Initializer for the LogoLayer
    /// view - determines the container to which the logo get's added
    /// scale - the scale factor for the logo. Default Logo Size is 74 * 48 - To increase or decrease the size of the logo. Default scale is 1
    /// lineWidth - determines the width of the stroke
    /// trackColor - determines the color of the path
    /// strokeColor - determines the color of the fill
    init(for view: UIView, scale: CGFloat = 1, duration: TimeInterval, lineWidth: CGFloat, trackColor: UIColor, glideColor: UIColor, strokeColor: UIColor) {
        super.init()
        self.lineW = lineWidth
        self.logoFrame = view.bounds
        
        self.trackColor = trackColor
        self.glideColor = glideColor
        self.fillingColor = strokeColor
        
        self.scaleFactor = scale
        self.animationDuration = duration
        
        DispatchQueue.main.async {
            self.drawLogo(with: view.center)
        }
    }
    
    /// CAAnimation Delegate method
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (!sliderFinished) {
            let strokeEndAnimation = LayerAnimationFactory.getStrokeEndAnimation(duration: self.animationDuration)
            strokeEndAnimation.delegate = self
            fillLayer.add(strokeEndAnimation, forKey: "strokeEnd")
            sliderFinished = true
        } else {
            self.coreAnimationDelegate?.animationFinished()
        }
    }
    
    // MARK:- function to draw the logo
    func drawLogo(with center: CGPoint){
        let offset: CGFloat = 5
        let cX = center.x + offset / 2
        let cY = center.y + offset
        
        /// Little Mathematics for drawing the path of the animation
        let path = UIBezierPath()
        path.move(to: CGPoint(x: cX, y: cY))
        path.addLine(to: CGPoint(x: cX - (34 * scaleFactor), y: cY))
        path.addQuadCurve(to: CGPoint(x: cX + (6 * scaleFactor), y: cY - (27 * scaleFactor)), controlPoint: CGPoint(x: cX + (1.5 * scaleFactor), y: cY - (27 * scaleFactor)))
        path.addQuadCurve(to: CGPoint(x: cX + (20 * scaleFactor), y: cY + (12 * scaleFactor)), controlPoint: CGPoint(x: cX + (10 * scaleFactor), y: cY + (28 * scaleFactor)))
        path.addLine(to: CGPoint(x: cX + (30 * scaleFactor), y: cY))
        path.addLine(to: CGPoint(x: cX + (18 * scaleFactor), y: cY))
        
        /// for static logo pass the animationDuration as 0
        let strokeEnd: CGFloat = self.animationDuration > 0 ? 0 : 1
        
        logoLayer.setShapeLayer(path: path, frame: self.logoFrame, fillColor: UIColor.clear, lineWidth: self.lineW, strokeStart: 0, strokeEnd: 1, strokeColor: self.trackColor)
        glideLayer.setShapeLayer(path: path, frame: self.logoFrame, fillColor: UIColor.clear, lineWidth: self.lineW + 1, strokeStart: 0, strokeEnd: 0.0008, strokeColor: glideColor)
        fillLayer.setShapeLayer(path: path, frame: self.logoFrame, fillColor: UIColor.clear, lineWidth: self.lineW + 1, strokeStart: 0, strokeEnd: strokeEnd, strokeColor: self.fillingColor)
        
        // add the layers into the parent layer
        self.addSublayer(logoLayer)
        self.insertSublayer(fillLayer, above: self)
        self.insertSublayer(glideLayer, above: logoLayer)
        
        // animate the glideAnimation based on the duration
        let strokeStartAnimation = LayerAnimationFactory.getStrokeStartAnimation(duration: self.animationDuration * 0.75)
        let strokeEndAnimation = LayerAnimationFactory.getStrokeEndAnimation(duration: self.animationDuration * 0.75)
        strokeEndAnimation.delegate = self
        strokeEndAnimation.isRemovedOnCompletion = true
        
        glideLayer.add(strokeStartAnimation, forKey: "strokeStart")
        glideLayer.add(strokeEndAnimation, forKey: "strokeEnd")
        
    }
}
