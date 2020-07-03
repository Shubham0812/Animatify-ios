//
//  ExpandingButton.swift
//  Animatify
//
//  Created by Shubham Singh on 03/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit


enum ExpandDirection {
    case up
    case down
    case left
    case right
}

class ExpandingButton: UIButton {
    
    var buttons: [UIButton] = []
    var numberOfButtons = 1
    var buttonTransformed = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializer for the RejectButton
    /// type - determines the type of the button
    /// frame - the frame of the button
    /// borderColor - the borderColor of the button
    /// font - the font of the titleLabel of the button
    /// cornerRadius - the cornerRadius of the button
    /// tintColor- the tintColor of the button
    convenience init(type buttonType: UIButton.ButtonType, frame: CGRect, tintColor: UIColor, symbolName: String, ) {
        self.init(type: buttonType)
        self.frame = frame
        self.tintColor = tintColor
        
        initializeButton()
    }
    
    // MARK:- functions for the button
    func initializeButton() {
        
    }
    
    
    // MARK:- objc functions for the button
}
