//
//  CAExtensions.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit


extension CAShapeLayer {
    
    func setShapeLayer(path: UIBezierPath, frame: CGRect, fillColor: UIColor, lineWidth: CGFloat,strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, position: CGPoint){
        self.path = path.cgPath
        self.frame = frame
        self.fillColor = fillColor.cgColor
        self.lineWidth = lineWidth
        self.strokeStart = strokeStart
        self.strokeEnd = strokeEnd
        self.lineCap = .round
        self.strokeColor = strokeColor.cgColor
//        self.position = position
    }
}



