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
    var bluetoothButton = BluetoothButton()
    var wifiButton = WifiButton()

    
    var loaderType : LoaderType?
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        switch loaderType {
        case .success:
            drawSubmit()
        case .failure:
            drawReject()
        case .bluetooth:
            drawBluetooth()
        case .wifi:
            drawWifi()
        case .none:
            print("none")
        }
    }
    
}

// MARK:- extension for Submit animations
extension LoadersViewController {
    // MARK:- functions for the viewController
    func drawSubmit() {
        
        // Submit effect view
        let childView = UIView()
        self.view.addSubview(childView)
        
        childView.addAnchor(top: view.topAnchor, paddingTop: 200,
                        left: nil, paddingLeft: 0,
                        bottom: nil, paddingBottom: 0,
                        right: nil, paddingRight: 0,
                        width: 300, height: 300, enableInsets: true)
        childView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        /// successEffect1
        let successEffect = SubmitEffect1(for: childView,
                                    circleRadius: 74,
                                    scale: 1.5,
                                    duration: 1,
                                    lineWidth: 8,
                                    trackColor: UIColor.systemGreen)
        
        childView.layer.insertSublayer(successEffect, above: childView.layer)
        childView.layer.masksToBounds = false
        childView.layer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        
        // submit Button
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 70

        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260

        let submitButtonFrame = CGRect(x: cX - (buttonWidth / 2),
                                       y: cY - (buttonHeight / 2),
                                       width: buttonWidth,
                                       height: buttonHeight)

        submitButton = SubmitButton(type: .system,
                                    frame: submitButtonFrame,
                                    borderColor: UIColor.systemGreen,
                                    borderWidth: 4,
                                    font: UIFont(name: "Raleway-SemiBold", size: 24)!,
                                    cornerRadius: 12,
                                    tintColor: UIColor.white)

        submitButton.setTitle("Submit", for: .normal)
        self.view.addSubview(submitButton)

        submitButton.addAnchor(top: childView.bottomAnchor, paddingTop: 150,
                               left: nil, paddingLeft: 0,
                               bottom: nil, paddingBottom: 0,
                               right: nil, paddingRight: 0,
                               width: buttonWidth, height: buttonHeight,
                               enableInsets: true)
        submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true


        submitButton.addTarget(self, action: #selector(performSubmit), for: .touchUpInside)
    }
    
    @objc func performSubmit(){
        submitButton.perfomSubmitAction(parentView: self.view,
                                        circleButton: 84,
                                        duration: 0.75,
                                        borderWidth: 4,
                                        scale: 0.6,
                                        tickWidth: 6,
                                        tickColor:  UIColor.white,
                                        backgroundColor: UIColor.systemGreen)
        
        submitButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 70.0).isActive = true

    }
}

//MARK:- extension for Reject animations
extension LoadersViewController {
    
    // MARK:- functions for the viewController
    func drawReject(){
        
        // Reject effect view
        let childView = UIView()
        self.view.addSubview(childView)
        
        childView.addAnchor(top: view.topAnchor, paddingTop: 200,
                        left: nil, paddingLeft: 0,
                        bottom: nil, paddingBottom: 0,
                        right: nil, paddingRight: 0,
                        width: 300, height: 300, enableInsets: true)
        childView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        /// FailureEffect
        let rejectEffect = RejectEffect1(for: childView,
                                    circleRadius: 74,
                                    scale: 1.5,
                                    duration: 1,
                                    lineWidth: 8,
                                    trackColor: UIColor.red)
        
        childView.layer.insertSublayer(rejectEffect, above: childView.layer)
        childView.layer.masksToBounds = false
        childView.layer.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        
        // Reject Button
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 62
        
        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260
        
        let rejectButtonFrame = CGRect(x: cX - (buttonWidth / 2),
                                       y: cY - (buttonHeight / 2),
                                       width: buttonWidth, height: buttonHeight)
        
        rejectButton = RejectButton(type: .system,
                                    frame: rejectButtonFrame,
                                    borderColor: .red,
                                    borderWidth: 4,
                                    font: UIFont(name: "Raleway-SemiBold", size: 24)!,
                                    cornerRadius: 12,
                                    tintColor: UIColor.white)
        
        rejectButton.setTitle("Decline", for: .normal)
        self.view.addSubview(rejectButton)
        
        rejectButton.addAnchor(top: childView.bottomAnchor, paddingTop: 150,
                               left: nil, paddingLeft: 0,
                               bottom: nil, paddingBottom: 0,
                               right: nil, paddingRight: 0,
                               width: buttonWidth, height: buttonHeight,
                               enableInsets: true)
        rejectButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        rejectButton.addTarget(self, action: #selector(performReject), for: .touchUpInside)
    }
    
    @objc func performReject(){
        rejectButton.performRejectAction(parentView: self.view,
                                         circleButton: 84,
                                         duration: 0.75,
                                         borderWidth: 4,
                                         scale: 0.6,
                                         crossWidth: 6,
                                         tickColor: .white,
                                         backgroundColor: .systemRed)
        
        rejectButton.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        rejectButton.widthAnchor.constraint(equalToConstant: 70.0).isActive = true
    }
}

//MARK:- extension for Bluetooth animations
extension LoadersViewController {
    
    // MARK:- functions for the viewController
    func drawBluetooth(){
        let view = UIView()
        view.frame = CGRect(x: 60, y: 240, width: 300, height: 200)
        self.view.addSubview(view)
        
        /// Bluetooth effect
        let effect1 = BluetoothEffect1(for: view, circleRadius: 74, scale: 1.5, duration: 2.5, lineWidth: 12, trackColor: UIColor.white, fillingColor: .blue)
        
        self.view.layer.insertSublayer(effect1, above: self.view.layer)
        
        /// Bluetooth Button
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 62
        
        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260
        
        let bluetoothButtonFrame = CGRect(x: cX - (buttonWidth / 2), y: cY - (buttonHeight / 2), width: buttonWidth, height: buttonHeight)
        
        bluetoothButton = BluetoothButton(type: .system,
                                          frame: bluetoothButtonFrame,
                                          borderColor: .blue,
                                          borderWidth: 4,
                                          font: UIFont(name: "Raleway-SemiBold", size: 24)!,
                                          cornerRadius: 12,
                                          tintColor: UIColor.white)
        
        
        bluetoothButton.setTitle("Bluetooth", for: .normal)
        self.view.addSubview(bluetoothButton)
        bluetoothButton.addTarget(self, action: #selector(reformBluetoothConnect), for: .touchUpInside)
    }
    
    @objc func reformBluetoothConnect(){
        bluetoothButton.performBluetoothAction(parentView: self.view, circleButton: 84, duration: 2, borderWidth: 4, scale: 0.6, crossWidth: 6, tickColor: .white, backgroundColor: .blue)
    }
}

//MARK:- extension for Wifi animations
extension LoadersViewController {
    
    // MARK:- functions for the viewController
    func drawWifi(){
        let view = UIView()
        view.frame = CGRect(x: 60, y: 240, width: 300, height: 200)
        self.view.addSubview(view)
        
        /// Wifi effect
        let effect1 = WifiEffect1(for: view, circleRadius: 74, scale: 1.5, duration: 1, lineWidth: 12, trackColor: UIColor.white, fillingColor: .white)
        
        self.view.layer.insertSublayer(effect1, above: self.view.layer)
        
        /// Wifi Button
        let buttonWidth: CGFloat = 160
        let buttonHeight: CGFloat = 62
        
        let cX: CGFloat = self.view.center.x
        let cY: CGFloat = self.view.center.y + 260
        
        let wifiButtonFrame = CGRect(x: cX - (buttonWidth / 2), y: cY - (buttonHeight / 2), width: buttonWidth, height: buttonHeight)
        
        wifiButton = WifiButton(type: .system,
                                          frame: wifiButtonFrame,
                                          borderColor: .blue,
                                          borderWidth: 4,
                                          font: UIFont(name: "Raleway-SemiBold", size: 24)!,
                                          cornerRadius: 12,
                                          tintColor: UIColor.white)
        
        
        wifiButton.setTitle("Wifi", for: .normal)
//        self.view.addSubview(wifiButton)
//        wifiButton.addTarget(self, action: #selector(performWifiConnect), for: .touchUpInside)
    }
    
    @objc func performWifiConnect(){
        wifiButton.performWifiAction(parentView: self.view, circleButton: 84, duration: 0.75, borderWidth: 4, scale: 0.6, crossWidth: 6, tickColor: .white, backgroundColor: .blue)
    }
}
