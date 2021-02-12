//
//  IntroViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController, CoreAnimationDelegate {
    
    // MARK:- variables for the viewController
    var animationDuration: TimeInterval = 0.7
    
    /// show the animation, then transition into homeViewControllerFi
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logoView = UIView()
        logoView.frame = self.view.frame
        logoView.backgroundColor = Colors.background
    
        let logoLayer = LogoLayer(for: logoView, scale: 2, duration: self.animationDuration, lineWidth: 6, trackColor: Colors.accent, glideColor: Colors.logo, strokeColor: Colors.logo)
        logoView.layer.insertSublayer(logoLayer, below: logoView.layer)
        logoLayer.coreAnimationDelegate = self
        
        self.view.addSubview(logoView)
    }
    
    // CoreAnimationDelegate function
    func animationFinished() {
        guard let homeVC = self.storyboard?.instantiateViewController(identifier: HomeViewController.description()) as? HomeViewController else { return }
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
