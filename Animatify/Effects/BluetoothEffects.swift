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
    var view =  UIView()
    
    
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
            self.drawBluetooth(view: view)
        }
    }
    
    /// CAAnimation Delegate method
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let pulse = LayerAnimationFactory.getPulsatingAnimation(duration: 0.75)
        self.pulsatingLayer.add(pulse, forKey:"abcd")
    }
    
    // MARK:- functions for the CALayer
    /// The size of the Circle and the bluetooth is defined by two properties.
    /// Radius and scaleFactor determines the size.
    /// Everything else is configured, you have to provide a view.
    func drawBluetooth(view: UIView) {
        let cX: CGFloat = view.center.x
        let cY: CGFloat = view.center.y
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: cX, y: cY), radius: (radius * scaleFactor), startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        
        let bluetoothPath = UIBezierPath()
        bluetoothPath.move(to: CGPoint(x: cX - (25 * scaleFactor), y: cY - (28 * scaleFactor)))
        bluetoothPath.addLine(to: CGPoint(x: cX + (scaleFactor * 25), y: cY + (scaleFactor * 28)))
        bluetoothPath.addLine(to: CGPoint(x: cX , y: cY + (scaleFactor * 45)))
        bluetoothPath.addLine(to: CGPoint(x: cX , y: cY - (scaleFactor * 45)))
        bluetoothPath.addLine(to: CGPoint(x: cX + (scaleFactor * 25), y: cY - (scaleFactor * 28)))
        bluetoothPath.addLine(to: CGPoint(x: cX - (scaleFactor * 25), y: cY + (scaleFactor * 28)))
        
        circleLayer.setShapeLayer(path: circlePath, fillColor: fillingColor, lineWidth: lineW - 1.5, strokeStart: 0, strokeEnd: 0, strokeColor: .white)
        bluetoothLayer.setShapeLayer(path: bluetoothPath, fillColor: UIColor.clear, lineWidth: lineW, strokeStart: 0, strokeEnd: 0, strokeColor: self.lineColor)
        
        addPulsatingLayer()
        self.addSublayer(circleLayer)
        self.insertSublayer(bluetoothLayer, above: self)
        
        let strokeEnd = LayerAnimationFactory.getStrokeEndAnimation(duration: animationDuration)
        strokeEnd.delegate = self
        
        bluetoothLayer.add(strokeEnd, forKey: "strokeEnd")
    }
    
    func addPulsatingLayer() {
        let pulsatingPath = UIBezierPath(arcCenter: .zero,
                                         radius: (radius * scaleFactor),
                                         startAngle: -.pi/2,
                                         endAngle: 2 * .pi ,
                                         clockwise: true)
        pulsatingLayer.setShapeLayer(path: pulsatingPath, fillColor: fillingColor.withAlphaComponent(0.2), lineWidth: 15, strokeStart: 0, strokeEnd: 1, strokeColor: UIColor.clear)
        pulsatingLayer.position = view.center
        self.addSublayer(pulsatingLayer)
    }
}
