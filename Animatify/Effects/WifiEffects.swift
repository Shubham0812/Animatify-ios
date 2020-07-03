//
//  WifiEffects.swift
//  Animatify
//
//  Created by Aaryan Kothari on 04/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class WifiEffect1: CAShapeLayer, CAAnimationDelegate {
    
    var lineW: CGFloat = 0
    var logoFrame: CGRect = CGRect()
    var scaleFactor: CGFloat = 1
    var radius: CGFloat = 0
    var view =  UIView()
    
    
    var animationDuration: TimeInterval = 0
    var tickDifference: TimeInterval = 0.25
    
    var lineColor = UIColor()
    var fillingColor = UIColor()
    
    var circleLayer = CAShapeLayer()
    var wifiLayer = CAShapeLayer()
    
    var circleFinished = false
    var coreAnimationDelegate: CoreAnimationDelegate?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /// Initializer for the WifiEffect1
    /// view - determines the container to which the logo get's added
    /// circleRadius - the radius of the circle. Default radius size is 74
    /// scale - the scale factor for the logo.
    /// duration - the duration of the animation
    /// lineWidth - determines the width of the stroke
    /// trackColor - determines the color of the path
    init(for view: UIView, circleRadius: CGFloat, scale: CGFloat = 1, duration: TimeInterval, lineWidth: CGFloat, trackColor: UIColor, fillingColor: UIColor) {
        super.init()
        
        self.animationDuration = duration
        self.lineW = lineWidth
        self.lineColor = trackColor
        self.scaleFactor = scale
        self.radius = circleRadius
        self.fillingColor = fillingColor
        self.view = view
        DispatchQueue.main.async {
            self.drawWifi(view: view)
        }
    }
    
    /// CAAnimation Delegate method
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
       
    }
    
    // MARK:- functions for the CALayer
    /// The size of the Circle and the wifi is defined by two properties.
    /// Radius and scaleFactor determines the size.
    /// Everything else is configured, you have to provide a view.
    func drawWifi(view: UIView) {
        let cX: CGFloat = view.center.x
        let cY: CGFloat = view.center.y
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: cX, y: cY), radius: (radius * scaleFactor), startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let wifiPath = UIBezierPath()
        wifiPath.move(to: CGPoint(x: cX - (25 * scaleFactor), y: cY - (28 * scaleFactor)))
        wifiPath.addLine(to: CGPoint(x: cX + (scaleFactor * 25), y: cY + (scaleFactor * 28)))
        wifiPath.addLine(to: CGPoint(x: cX + (scaleFactor * 0), y: cY + (scaleFactor * 45)))
        wifiPath.addLine(to: CGPoint(x: cX + (scaleFactor * 0), y: cY - (scaleFactor * 45)))
        wifiPath.addLine(to: CGPoint(x: cX + (scaleFactor * 25), y: cY - (scaleFactor * 28)))
        wifiPath.addLine(to: CGPoint(x: cX - (scaleFactor * 25), y: cY + (scaleFactor * 28)))
        
        circleLayer.setShapeLayer(path: circlePath, fillColor: fillingColor, lineWidth: lineW - 1.5, strokeStart: 0, strokeEnd: 0, strokeColor: .white, position: view.center)
        wifiLayer.setShapeLayer(path: wifiPath, fillColor: UIColor.clear, lineWidth: lineW, strokeStart: 0, strokeEnd: 0, strokeColor: self.lineColor, position: view.center)
        
        self.addSublayer(circleLayer)
        self.insertSublayer(wifiLayer, above: self)
        
        let strokeEnd = LayerAnimationFactory.getStrokeEndAnimation(duration: animationDuration)
        strokeEnd.delegate = self
        
        wifiLayer.add(strokeEnd, forKey: "strokeEnd")
    }
}



