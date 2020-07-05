//
//  FailureEffects.swift
//  Animatify
//
//  Created by Aaryan Kothari on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class RejectEffect1: CAShapeLayer, CAAnimationDelegate {
    
    var lineW: CGFloat = 0
    var logoFrame: CGRect = CGRect()
    var scaleFactor: CGFloat = 1
    var radius: CGFloat = 0
    
    
    var animationDuration: TimeInterval = 0
    var tickDifference: TimeInterval = 0.25
    
    var lineColor = UIColor()
    var fillingColor = UIColor()
    
    var circleLayer = CAShapeLayer()
    var crossLayer = CAShapeLayer()
    
    var circleFinished = false
    var coreAnimationDelegate: CoreAnimationDelegate?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /// Initializer for the RejectEffect1
    /// view - determines the container to which the logo get's added
    /// circleRadius - the radius of the circle. Default radius size is 74
    /// scale - the scale factor for the logo.
    /// duration - the duration of the animation
    /// lineWidth - determines the width of the stroke
    /// trackColor - determines the color of the path
    init(for view: UIView, circleRadius: CGFloat, scale: CGFloat = 1, duration: TimeInterval, lineWidth: CGFloat, trackColor: UIColor) {
        super.init()
        
        self.animationDuration = duration
        self.lineW = lineWidth
        self.lineColor = trackColor
        self.scaleFactor = scale
        self.radius = circleRadius
        
        DispatchQueue.main.async {
            self.drawfailure(view: view)
        }
    }
    
    /// CAAnimation Delegate method
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let strokeEnd = LayerAnimationFactory.getStrokeEndAnimation(duration: self.animationDuration / 2)
        self.crossLayer.add(strokeEnd, forKey: "strokeEnd")
    }
    
    // MARK:- functions for the CALayer
    /// The size of the Circle and the Cross is defined by two properties.
    /// Radius and scaleFactor determines the size.
    /// Everything else is configured, you have to provide a view.
    func drawfailure(view: UIView) {
        let cX: CGFloat = view.center.x
        let cY: CGFloat = view.center.y
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: cX, y: cY), radius: (radius * scaleFactor), startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: cX - (32 * scaleFactor), y: cY - (32 * scaleFactor)))
        crossPath.addLine(to: CGPoint(x: cX + (scaleFactor * 32), y: cY + (scaleFactor * 32)))
        crossPath.move(to: CGPoint(x: cX - (32 * scaleFactor), y: cY + (32 * scaleFactor)))
        crossPath.addLine(to: CGPoint(x: cX + (scaleFactor * 32), y: cY - (scaleFactor * 32)))

        
        circleLayer.setShapeLayer(path: circlePath, fillColor: UIColor.clear, lineWidth: lineW - 1.5, strokeStart: 0, strokeEnd: 0, strokeColor: self.lineColor)
        crossLayer.setShapeLayer(path: crossPath, fillColor: UIColor.clear, lineWidth: lineW, strokeStart: 0, strokeEnd: 0, strokeColor: self.lineColor)
        
        self.addSublayer(circleLayer)
        self.insertSublayer(crossLayer, above: self)
        
        let strokeEnd = LayerAnimationFactory.getStrokeEndAnimation(duration: animationDuration)
        strokeEnd.delegate = self
        
        circleLayer.add(strokeEnd, forKey: "end")
    }
}
