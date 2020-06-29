//
//  LoadersViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 25/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class LoadersViewController: UIViewController {
    
    override class func description() -> String {
        return "LoadersViewController"
    }
    
    // MARK:- variables for the viewController
    var buttonTransform = false
    var submitButton = SubmitButton()
    var rejectButton = RejectButton()
        
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
       // drawSubmit()
        drawReject()
    }
    
    // MARK:- functions for the viewController
    func drawSubmit(){
        let view = UIView()
        view.frame = CGRect(x: 60, y: 240, width: 300, height: 200)
        self.view.addSubview(view)
        
        /// successEffect1
        let effect1 = SubmitEffect1(for: view, circleRadius: 74, scale: 1.5, duration: 2.5, lineWidth: 8, trackColor: UIColor.systemGreen)
        self.view.layer.insertSublayer(effect1, above: self.view.layer)
    
        /// submit Button
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 62
        
        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260
        
        let submitButtonFrame = CGRect(x: cX - (buttonWidth / 2), y: cY - (buttonHeight / 2), width: buttonWidth, height: buttonHeight)
        
        submitButton = SubmitButton(type: .system, frame: submitButtonFrame, borderColor: UIColor.systemGreen, borderWidth: 4,
                                    font: UIFont(name: "Raleway-SemiBold", size: 24)!, cornerRadius: 12, tintColor: UIColor.white)
        submitButton.setTitle("Submit", for: .normal)
        self.view.addSubview(submitButton)
        
        submitButton.addTarget(self, action: #selector(performSubmit), for: .touchUpInside)
    }
    
    @objc func performSubmit(){
        submitButton.perfomSubmitAction(parentView: self.view, circleButton: 84, duration: 2, borderWidth: 4, scale: 0.6, tickWidth: 6,
                                        tickColor:  UIColor.white, backgroundColor: UIColor.systemGreen)
    }
}

//MARK:- extension for Reject animations
extension LoadersViewController {
    // MARK:- functions for the viewController
    func drawReject(){
        let view = UIView()
        view.frame = CGRect(x: 60, y: 240, width: 300, height: 200)
        self.view.addSubview(view)
        
        /// FailureEffect
        let effect1 = SubmitEffect1(for: view, circleRadius: 74, scale: 1.5, duration: 2.5, lineWidth: 8, trackColor: UIColor.systemGreen)
        self.view.layer.insertSublayer(effect1, above: self.view.layer)
    
        /// Reject Button
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 62
        
        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260
        
        let rejectButtonFrame = CGRect(x: cX - (buttonWidth / 2), y: cY - (buttonHeight / 2), width: buttonWidth, height: buttonHeight)
        
        rejectButton = RejectButton(type: .system, frame: rejectButtonFrame, borderColor: .red, borderWidth: 4,
                                    font: UIFont(name: "Raleway-SemiBold", size: 24)!, cornerRadius: 12, tintColor: UIColor.white)
        rejectButton.setTitle("Decline", for: .normal)
        self.view.addSubview(rejectButton)
        
        submitButton.addTarget(self, action: #selector(performReject), for: .touchUpInside)
    }
    
    @objc func performReject(){
        rejectButton.performRejectAction(parentView: self.view, circleButton: 84, duration: 2, borderWidth: 4, scale: 0.6, crossWidth: 6, tickColor: .white, backgroundColor: .systemRed)
    }
}
