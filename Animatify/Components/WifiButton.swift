//
//  WifiButton.swift
//  Animatify
//
//  Created by Aaryan Kothari on 04/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit


class WifiButton: UIButton {
    
    let wifiLayer = CAShapeLayer()
    
    // MARK:- initializers for the UIButton
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializer for the WifiButton
    /// type - determines the type of the button
    /// frame - the frame of the button
    /// borderColor - the borderColor of the button
    /// font - the font of the titleLabel of the button
    /// cornerRadius - the cornerRadius of the button
    /// tintColor- the tintColor of the button
    convenience init(type buttonType: UIButton.ButtonType, frame: CGRect, borderColor: UIColor, borderWidth: CGFloat, font: UIFont, cornerRadius: CGFloat, tintColor: UIColor = UIColor.label) {
        self.init(type: buttonType)
        self.frame = frame
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.titleLabel?.font = font
        self.tintColor = tintColor
        self.roundCorners(cornerRadius: cornerRadius)
    }
    
    // MARK:- functions for the button
    
    func performWifiAction(parentView: UIView, circleButton: CGFloat, duration: TimeInterval, borderWidth: CGFloat, scale: CGFloat, crossWidth: CGFloat, tickColor: UIColor, backgroundColor: UIColor) {
        DispatchQueue.main.async {
            self.setTitle("", for: .normal)
            ViewAnimationFactory.makeEaseInAnimation(duration: duration / 3, delay: 0) {
                self.layer.borderWidth = borderWidth
                self.frame = CGRect(x: self.center.x - (circleButton / 2), y: self.center.y - (circleButton / 2), width: circleButton, height: circleButton)
                self.roundCorners(cornerRadius: self.frame.width / 2.0)
                                
                let cX: CGFloat = self.center.x
                let cY: CGFloat = self.center.y
                

                let wifiPath = UIBezierPath()
                wifiPath.move(to: CGPoint(x: cX - (25 * scale), y: cY - (28 * scale)))
                wifiPath.addLine(to: CGPoint(x: cX + (scale * 25), y: cY + (scale * 28)))
                wifiPath.addLine(to: CGPoint(x: cX , y: cY + (scale * 45)))
                wifiPath.addLine(to: CGPoint(x: cX , y: cY - (scale * 45)))
                wifiPath.addLine(to: CGPoint(x: cX + (scale * 25), y: cY - (scale * 28)))
                wifiPath.addLine(to: CGPoint(x: cX - (scale * 25), y: cY + (scale * 28)))
                
                
                self.wifiLayer.setShapeLayer(path: wifiPath, fillColor: UIColor.clear, lineWidth: crossWidth, strokeStart: 0, strokeEnd: 0, strokeColor: tickColor)
                parentView.layer.insertSublayer(self.wifiLayer, above: self.layer)
            }
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            }) { finished in
                let strokeEndAnimation = LayerAnimationFactory.getStrokeEndAnimation(duration: duration)
                self.wifiLayer.add(strokeEndAnimation, forKey: "strokeEnd")
                ViewAnimationFactory.makeSimpleAnimation(duration: duration) {
                    self.backgroundColor = backgroundColor
                }
            }
        }
    }
}
