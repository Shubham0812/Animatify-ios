//
//  IntroViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, CoreAnimationDelgate {
    
    /// show the animation, then transition into homeViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoView = UIView()
        logoView.frame = self.view.frame
        logoView.backgroundColor = UIColor(named: "background")
        guard let accentColor = UIColor(named: "accentColor") else { return }
    
        let logoLayer = LogoLayer(for: logoView, scale: 2, duration: 1.5, lineWidth: 6, trackColor: accentColor, glideColor: UIColor(hex: "#18FFFF"), strokeColor: UIColor.white)
        logoView.layer.insertSublayer(logoLayer, below: logoView.layer)
        logoLayer.coreAnimationDelegate = self
        
        self.view.addSubview(logoView)
    }
    
    // CoreAnimationDelegate function
    func animationFinished() {
        guard let homeVC = self.storyboard?.instantiateViewController(identifier: HomeViewController.description()) else { return }
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
