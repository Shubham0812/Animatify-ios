//
//  ExpandingButtonsView.swift
//  Animatify
//
//  Created by Shubham Singh on 03/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit


class ExpandingButtonsView: UIView {
    
    // MARK:- variables for the view
    var numberOfButtons = 0
    var primaryButtonWidth: CGFloat = 80
    var secondaryButtonWidth: CGFloat = 70
    var buttonSpacing: CGFloat = 15
    
    var expandDirection: ExpandDirection = .down
    
    var buttonTransformed = false
    var symbolNames: [String] = []
    var symbolTint: [UIColor] = []
    
    var largeButtonSize: CGFloat = 0
    var smallButtonSize: CGFloat = 0
    
    var cX: CGFloat = 0
    var cY: CGFloat = 0
    
    /// button difference offset
    var dX: CGFloat = 0
    var dY: CGFloat = 0
    
    var buttons: [UIButton] = []
        


    // MARK:- initializers for the view
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Initializer for the View
    /// numberOfButtons - the number of buttons needed for the view
    /// symbolNames - an array for the symbols for the button
    /// symbolTint - an array for the tintColor of the symbols
    /// expandDirection - an enum specifying the direction of the expansion
    /// largeButtonSize - buttonSize for the primary button
    /// smallButtonSize - buttonSize for the additional buttons
    init(frame: CGRect, numberOfButtons: Int, symbolNames: [String], symbolTint: [UIColor], expandDirection: ExpandDirection, largeButtonSize: CGFloat, smallButtonSize: CGFloat) {
        super.init(frame: frame)
        self.numberOfButtons = numberOfButtons
        self.symbolNames = symbolNames
        self.symbolTint = symbolTint
        
        self.expandDirection = expandDirection
        self.largeButtonSize = largeButtonSize
        self.smallButtonSize = smallButtonSize
        
        /// determing the centerX `cX` and centerY `cY` for the additional buttons
        switch self.expandDirection {
        case .down:
            cX = self.bounds.maxX / 2
            cY = self.bounds.minY + primaryButtonWidth / 2
        case .up:
            cX = self.bounds.maxX / 2
            cY = self.bounds.maxY - primaryButtonWidth / 2
        case .left:
            cX = self.bounds.maxX - (primaryButtonWidth / 2)
            cY = primaryButtonWidth / 2
        case .right:
            cX = (primaryButtonWidth / 2)
            cY = primaryButtonWidth / 2
        }
        setButtons()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK:- functions for the view
    func setButtons() {
        
        /// determining the `dX` and `dY` the origin for the additional buttons based on the expand direction
        switch self.expandDirection {
        case .down:
            self.dY =  (primaryButtonWidth / 2) + (secondaryButtonWidth / 1.5 )
        case .up:
            self.dY = -((primaryButtonWidth / 2) + (secondaryButtonWidth / 2))
        case .left:
            self.dX = -((primaryButtonWidth / 2) + (secondaryButtonWidth / 2))
        case .right:
            self.dX = ((primaryButtonWidth / 2) + (secondaryButtonWidth / 2))
        }
        
        /// adding the primary button, this is the button that gets expanded
        let primaryButton = UIButton(type: .system)
        primaryButton.frame = CGRect(x: cX - (primaryButtonWidth) / 2, y: cY - (primaryButtonWidth) / 2, width: primaryButtonWidth, height: primaryButtonWidth)
        primaryButton.layer.borderColor = UIColor.orange.cgColor
        primaryButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: largeButtonSize, weight: .medium)), for: .normal)
        primaryButton.tintColor = UIColor.white
        self.addSubview(primaryButton)
        
        primaryButton.addTarget(self, action: #selector(animateButton), for: .touchUpInside)
        
        
        /// adding the buttons to the view based on numberOfButtons
        for i in 0 ..< self.numberOfButtons {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: primaryButton.center.x - (secondaryButtonWidth) / 2 + dX, y: primaryButton.frame.origin.y + dY, width: secondaryButtonWidth, height: secondaryButtonWidth)
            button.layer.borderColor = UIColor.orange.cgColor
            
            button.setImage(UIImage(systemName: symbolNames[i], withConfiguration: UIImage.SymbolConfiguration(pointSize: smallButtonSize, weight: .medium)), for: .normal)
            button.tintColor = self.symbolTint[i]
            self.addSubview(button)
            self.sendSubviewToBack(button)
            
            buttons.append(button)
            button.layer.opacity = 0
            
            /// moving the buttons based on expand direction
            switch self.expandDirection {
            case .down:
                dY += secondaryButtonWidth
                button.transform = CGAffineTransform(translationX: 0, y: -(secondaryButtonWidth / 2))
            case .up:
                dY -= secondaryButtonWidth
                button.transform = CGAffineTransform(translationX: 0, y: secondaryButtonWidth / 2)
            case .left:
                dX -= secondaryButtonWidth
                button.transform = CGAffineTransform(translationX: secondaryButtonWidth / 2, y: 0)
            case .right:
                dX += secondaryButtonWidth
                button.transform = CGAffineTransform(translationX: -secondaryButtonWidth / 2, y: 0)
            }
        }
    }
    
    // MARK:- objc functions for the ciew
    @objc func animateButton(sender: Any) {
        guard let sender = sender as? UIButton else { return }
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
                var primaryButtonTransform = CGAffineTransform.identity
                var secondaryButtonTransform = CGAffineTransform.identity
                
                if (!self.buttonTransformed) {
                    primaryButtonTransform = primaryButtonTransform.rotated(by: CGFloat(43).degreeToRadians())
                    primaryButtonTransform = primaryButtonTransform.scaledBy(x: 1.1, y: 1.1)
                    
                    secondaryButtonTransform = secondaryButtonTransform.scaledBy(x: 1.1, y: 1.1)
                    self.buttons.forEach({$0.layer.opacity = 1})
                } else {
                    primaryButtonTransform = primaryButtonTransform.rotated(by: 0)
                    primaryButtonTransform = primaryButtonTransform.scaledBy(x: 1, y: 1)
                    self.buttons.forEach({$0.layer.opacity = 0})

                    /// animating the button by scaling them, the direction is dependent upin the expand direction
                    switch self.expandDirection {
                    case .down:
                        secondaryButtonTransform = secondaryButtonTransform.translatedBy(x: 0, y: -(self.secondaryButtonWidth / 2))
                        secondaryButtonTransform = secondaryButtonTransform.scaledBy(x: 0.01, y: 0.01)
                    case .up:
                        secondaryButtonTransform = secondaryButtonTransform.translatedBy(x: 0, y: (self.secondaryButtonWidth / 2))
                        secondaryButtonTransform = secondaryButtonTransform.scaledBy(x: 0.01, y: 0.01)
                    case .left:
                        secondaryButtonTransform = secondaryButtonTransform.translatedBy(x: (self.secondaryButtonWidth / 2), y: 0)
                        secondaryButtonTransform = secondaryButtonTransform.scaledBy(x: 0.01, y: 0.01)
                    case .right:
                        secondaryButtonTransform = secondaryButtonTransform.translatedBy(x: -(self.secondaryButtonWidth / 2), y: 0)
                        secondaryButtonTransform = secondaryButtonTransform.scaledBy(x: 0.01, y: 0.01)
                    }
                }
                
                /// applying the transformation to the additional buttons
                self.buttons.forEach({$0.transform = secondaryButtonTransform})
                
                /// applying the transformation to the primary button
                sender.transform = primaryButtonTransform
                self.buttonTransformed.toggle()
            })
        }
    }
}
