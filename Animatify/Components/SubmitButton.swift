//
//  SuccessButton.swift
//  Animatify
//
//  Created by Shubham Singh on 27/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class SubmitButton: UIButton {
    
    let tickLayer = CAShapeLayer()
    
    // MARK:- initializers for the UIButton
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializer for the SubmitButton
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
    func perfomSubmitAction(parentView: UIView, circleButton: CGFloat, duration: TimeInterval, borderWidth: CGFloat, scale: CGFloat, tickWidth: CGFloat, tickColor: UIColor, backgroundColor: UIColor) {
        DispatchQueue.main.async {
            self.setTitle("", for: .normal)
            ViewAnimationFactory.makeEaseInAnimation(duration: duration / 3, delay: 0) {
                self.layer.borderWidth = borderWidth
                self.frame = CGRect(x: self.center.x - (circleButton / 2), y: self.center.y - (circleButton / 2), width: circleButton, height: circleButton)
                self.roundCorners(cornerRadius: self.frame.width / 2.0)
                                
                let cX: CGFloat = self.center.x
                let cY: CGFloat = self.center.y
                
                let tickPath = UIBezierPath()
                tickPath.move(to: CGPoint(x: cX - (42 * scale), y: cY - (4 * scale)))
                tickPath.addLine(to: CGPoint(x: cX - (scale * 18), y: cY + (scale * 28)))
                tickPath.addLine(to: CGPoint(x: cX + (scale * 42), y: cY - (scale * 30)))
                
                self.tickLayer.setShapeLayer(path: tickPath, fillColor: UIColor.clear, lineWidth: tickWidth, strokeStart: 0, strokeEnd: 0, strokeColor: tickColor)
                parentView.layer.insertSublayer(self.tickLayer, above: self.layer)
            }
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            }) { finished in
                let strokeEndAnimation = LayerAnimationFactory.getStrokeEndAnimation(duration: duration)
                self.tickLayer.add(strokeEndAnimation, forKey: "strokeEnd")
                ViewAnimationFactory.makeSimpleAnimation(duration: duration) {
                    self.backgroundColor = backgroundColor
                }
            }
        }
    }
}
