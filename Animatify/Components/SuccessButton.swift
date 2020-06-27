//
//  SuccessButton.swift
//  Animatify
//
//  Created by Shubham Singh on 27/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class SubmitButton: UIButton {
    
    let shape2 = CAShapeLayer()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializer for the Suvmi
    /// view - determines the container to which the logo get's added
    /// circleRadius - the radius of the circle. Default radius size is 74
    /// scale - the scale factor for the logo.
    /// duration - the duration of the animation
    /// lineWidth - determines the width of the stroke
    /// trackColor - determines the color of the path
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
    
    func perfomSubmitAction(action: @escaping() -> Void) {
     
        
    }
}
