//
//  LogoAnimation.swift
//  Animatify
//
//  Created by Shubham Singh on 15/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation
import UIKit

final class LogoLayer: CAShapeLayer {
    
    var lineW: CGFloat = 0
    var logoFrame: CGRect = CGRect()
    var scaleFactor: CGFloat = 0
    var animationDuration: TimeInterval = 0
    
    var trackColor = UIColor()
    var fillingColor = UIColor()

    // MARK:- initializers for the CALayer
    override init() {
        super.init()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(for view: UIView, scale: CGFloat, duration: TimeInterval, lineWidth: CGFloat, trackColor: UIColor, strokeColor: UIColor) {
        super.init()
        self.lineW = lineWidth
        self.logoFrame = view.bounds
        
        self.trackColor = trackColor
        self.fillingColor = strokeColor
        
        self.scaleFactor = scale
        self.animationDuration = duration
        
        DispatchQueue.main.async {
            self.drawLogo(with: view.center)
        }
    }
    
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
        
        /// Now we add the layers
        let logo = CAShapeLayer()
        logo.path = path.cgPath
        logo.frame = self.logoFrame
        logo.fillColor = UIColor.clear.cgColor
        logo.lineWidth = self.lineW
        logo.strokeEnd = 1
        logo.lineCap = .round
        logo.strokeColor = self.trackColor.cgColor
        
        
        let fillLayer = CAShapeLayer()
        fillLayer.fillColor = UIColor.clear.cgColor
        fillLayer.frame = self.logoFrame
        
        fillLayer.strokeColor = self.fillingColor.cgColor
        fillLayer.path = path.cgPath
        fillLayer.lineWidth = self.lineW + 1
        fillLayer.lineCap = .round
        fillLayer.strokeStart = 0
        fillLayer.strokeEnd = 0
        
        self.addSublayer(logo)
        self.insertSublayer(fillLayer, above: self)
        
        let strokeEndAnimation = LayerAnimation.getAnimation(.strokeEnd(duration: self.animationDuration))
        fillLayer.add(strokeEndAnimation(), forKey: "anim")
    }
}
