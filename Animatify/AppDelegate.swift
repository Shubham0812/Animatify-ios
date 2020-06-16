//
//  AppDelegate.swift
//  Animatify
//
//  Created by Shubham Singh on 13/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        /// add logo animation for the launchScreen
        guard let window = window else { return true }
        
        let logoView = UIView()
        logoView.frame = window.frame
        logoView.backgroundColor = UIColor(named: "background")
        guard let accentColor = UIColor(named: "accentColor") else { return true }
        let logoLayer = LogoLayer(for: logoView, scale: 2, duration: 0.95, lineWidth: 6, trackColor: accentColor, strokeColor: UIColor.white)
        logoView.layer.insertSublayer(logoLayer, below: logoView.layer)
        
        window.makeKeyAndVisible()
        window.addSubview(logoView)
        
        // remove the animation
        Timer.scheduledTimer(withTimeInterval: 1.05, repeats: false) { (Timer) in
            ViewAnimationFactory.makeEaseOutAnimation(duration: 0.25, delay: 0) {
                logoView.layer.opacity = 0
            }
        }
        return true
    }
}

