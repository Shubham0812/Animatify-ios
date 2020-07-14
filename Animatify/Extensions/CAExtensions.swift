//
//  CAExtensions.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit
extension CAShapeLayer {
    func setShapeLayer(path: UIBezierPath, frame: CGRect = CGRect(), fillColor: UIColor, lineWidth: CGFloat,strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor){
        self.path = path.cgPath
        self.frame = frame
        self.fillColor = fillColor.cgColor
        self.lineWidth = lineWidth
        self.strokeStart = strokeStart
        self.strokeEnd = strokeEnd
        self.lineCap = .round
        self.strokeColor = strokeColor.cgColor
    }
}

extension CAGradientLayer {
    func setGradientLayer(color1: UIColor, color2: UIColor, for containerView: UIView, cornerRadius: CGFloat, startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0), endPoint: CGPoint = CGPoint(x: 1.0, y: 0.5)) {
        self.colors = [color1.cgColor, color2.cgColor]
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.frame = containerView.bounds
        self.cornerRadius = cornerRadius
    }
    
    func setGradientLayerWithLocation(color1: UIColor, color2: UIColor, with frame: CGRect, cornerRadius: CGFloat) {
        self.frame = frame
        self.colors = [color1.cgColor, color2.cgColor]
        self.cornerRadius = cornerRadius
        self.locations = [0.5, 1.0]
    }
}

extension CGFloat {
    func toDouble() -> Double {
        return Double(self)
    }
}



