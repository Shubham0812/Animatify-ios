//
//  ViewExtensions.swift
//  Animatify
//
//  Created by Shubham Singh on 14/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

extension UIView {
    /// For rounding the corners of the view
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
    
    func addAnchor(top: NSLayoutYAxisAnchor?, paddingTop: CGFloat,
                left: NSLayoutXAxisAnchor?, paddingLeft: CGFloat,
                bottom: NSLayoutYAxisAnchor?, paddingBottom: CGFloat,
                right: NSLayoutXAxisAnchor?, paddingRight: CGFloat,
                width: CGFloat, height: CGFloat,
                enableInsets: Bool) {
        
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
//
//            print("Top: \(topInset)")
//            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
}

extension UILabel {
    /// for setting cornerRadius and borderWidth
    func setBorderAndCorner(borderColor: UIColor, borderWidth: CGFloat, cornerRadius: CGFloat) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}

extension UIButton {
    func setBorder(with color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}



/// Typing Extension for the TextField
extension UITextField{
    func typeOn(string: String, typeInterval: TimeInterval) {
        let characterArray = string.characterArray
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: typeInterval, repeats: true) { (timer) in
            while characterArray[characterIndex] == " " {
                self.text! += " "
                characterIndex += 1
                if characterIndex == characterArray.count {
                    timer.invalidate()
                    return
                }
            }
            UIView.transition(with: self,
                              duration: typeInterval,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.text! += String(characterArray[characterIndex])
            })
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
                self.delegate?.textFieldDidEndEditing?(self)
            }
        }
    }
    
    /// For setting gradient of the TextField
    func setGradientText(parent: UIView, color1: UIColor = UIColor.systemPink, color2: UIColor = UIColor.systemPurple) {
        let view = UIView(frame: self.frame)
        parent.addSubview(view)
        let gradient = CAGradientLayer()
        gradient.setGradientLayer(color1: color1, color2: color2, for: self, cornerRadius: 0)
        
        view.layer.addSublayer(gradient)
        view.addSubview(self)
        view.layer.mask = self.layer
    }
}

/// Typing Extension for the TextView
extension UITextView {
    func typeOn(string: String, typeInterval: TimeInterval) {
        let characterArray = string.characterArray
        var characterIndex = 0
        Timer.scheduledTimer(withTimeInterval: typeInterval, repeats: true) { (timer) in
            while characterArray[characterIndex] == " " {
                self.text.append(" ")
                characterIndex += 1
                if characterIndex == characterArray.count {
                    timer.invalidate()
                    return
                }
            }
            UIView.transition(with: self,
                              duration: typeInterval,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.text.append(characterArray[characterIndex])
            })
            characterIndex += 1
            if characterIndex == characterArray.count {
                timer.invalidate()
                self.delegate?.textViewDidEndEditing?(self)
            }
        }
    }
}


extension String {
    var characterArray: [Character]{
        var characterArray = [Character]()
        for character in self {
            characterArray.append(character)
        }
        return characterArray
    }
}
