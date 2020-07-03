//
//  BluetoothEffect.swift
//  Animatify
//
//  Created by Aaryan Kothari on 03/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class BluetoothEffect1: CAShapeLayer, CAAnimationDelegate {
    
    var lineW: CGFloat = 0
    var logoFrame: CGRect = CGRect()
    var scaleFactor: CGFloat = 1
    var radius: CGFloat = 0
    
    
    var animationDuration: TimeInterval = 0
    var tickDifference: TimeInterval = 0.25
    
    var lineColor = UIColor()
    var fillingColor = UIColor()
    
    var circleLayer = CAShapeLayer()
    var bluetoothLayer = CAShapeLayer()
    var pulsatingLayer = CAShapeLayer()
    
    var circleFinished = false
    var coreAnimationDelegate: CoreAnimationDelegate?
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    /// Initializer for the BluetoothEffect1
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
            self.drawBluetooth(view: view)
        }
    }
    
    /// CAAnimation Delegate method
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
//        let strokeEnd = LayerAnimationFactory.getStrokeEndAnimation(duration: self.animationDuration)
//        self.bluetoothLayer.strokeColor = UIColor.white.cgColor
//        self.bluetoothLayer.add(strokeEnd, forKey: "strokeEnd")
    }
    
    // MARK:- functions for the CALayer
    /// The size of the Circle and the Cross is defined by two properties.
    /// Radius and scaleFactor determines the size.
    /// Everything else is configured, you have to provide a view.
    func drawBluetooth(view: UIView) {
        let cX: CGFloat = view.center.x
        let cY: CGFloat = view.center.y
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: cX, y: cY), radius: (radius * scaleFactor), startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let bluetoothPath = UIBezierPath()
        bluetoothPath.move(to: CGPoint(x: cX - (25 * scaleFactor), y: cY - (28 * scaleFactor)))
        bluetoothPath.addLine(to: CGPoint(x: cX + (scaleFactor * 25), y: cY + (scaleFactor * 28)))
        bluetoothPath.addLine(to: CGPoint(x: cX + (scaleFactor * 0), y: cY + (scaleFactor * 45)))
        bluetoothPath.addLine(to: CGPoint(x: cX + (scaleFactor * 0), y: cY - (scaleFactor * 45)))
        bluetoothPath.addLine(to: CGPoint(x: cX + (scaleFactor * 25), y: cY - (scaleFactor * 28)))
        bluetoothPath.addLine(to: CGPoint(x: cX - (scaleFactor * 25), y: cY + (scaleFactor * 28)))
        
        circleLayer.setShapeLayer(path: circlePath, fillColor: .blue, lineWidth: lineW - 1.5, strokeStart: 0, strokeEnd: 0, strokeColor: .white, position: view.center)
        bluetoothLayer.setShapeLayer(path: bluetoothPath, fillColor: UIColor.clear, lineWidth: lineW, strokeStart: 0, strokeEnd: 0, strokeColor: self.lineColor, position: view.center)
        
        setPulsatingLayer(view: view)
        self.addSublayer(circleLayer)
        self.insertSublayer(bluetoothLayer, above: self)
        
        let strokeEnd = LayerAnimationFactory.getStrokeEndAnimation(duration: animationDuration)
        strokeEnd.delegate = self
                
        bluetoothLayer.add(strokeEnd, forKey: "strokeEnd")
    }
    
    func setPulsatingLayer(view: UIView){
        let pulsatingPath = UIBezierPath(arcCenter: view.center, radius: (radius * scaleFactor), startAngle: 0, endAngle: 2 * .pi , clockwise: true)
//        pulsatingLayer.path = pulsatingPath.cgPath
//        pulsatingLayer.strokeColor=UIColor.clear.cgColor
//        pulsatingLayer.lineWidth=15
//        pulsatingLayer.lineCap=CAShapeLayerLineCap.round
//        pulsatingLayer.fillColor=UIColor(displayP3Red: 193/255.0, green: 255/255.0, blue: 244/255.0, alpha: 0.5).cgColor
//        pulsatingLayer.position=CGPoint(x:160,y:260)
        pulsatingLayer.setShapeLayer(path: pulsatingPath, fillColor: .blue, lineWidth: lineW - 1.5, strokeStart: 0, strokeEnd: 0, strokeColor: .white, position: view.center)
        self.addSublayer(pulsatingLayer)


        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.5
        animation.duration=1
        animation.timingFunction=CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        animation.autoreverses=true
        animation.repeatCount = Float.infinity
        pulsatingLayer.add(animation, forKey:"abcd")
    }
}
