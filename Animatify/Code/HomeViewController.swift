//
//  HomeViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 14/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var logoView: UIView!
    
    var containerToggled: Bool = false {
        didSet {
            if (containerToggled) {
                self.containerView.roundCorners(cornerRadius: 20)
            } else {
                self.containerView.roundCorners(cornerRadius: 42)
            }
        }
    }
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.drawLogo()
    }
    
    // MARK:- outlets for the viewController
    @IBAction func expandButtonPressed(_ sender: Any) {
        ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.75, delay: 0) {
            self.expandButton.transform = self.expandButton.transform.rotated(by: +CGFloat.pi + 0.00000001)
            var containerViewTransform = CGAffineTransform.identity
            containerViewTransform = containerViewTransform.translatedBy(x: 0, y: self.view.frame.height - self.containerView.frame.origin.y - 100)
            self.containerView.transform = containerViewTransform
            self.containerToggled = !self.containerToggled
        }
    }
    
    // MARK:- utility functions for the viewController
    func setupViews() {
        self.containerView.roundCorners(cornerRadius: 42)
        
        // set the section to collapsed
        self.expandButton.transform = self.expandButton.transform.rotated(by: +CGFloat.pi + 0.00000001)
        var containerViewTransform = CGAffineTransform.identity
        containerViewTransform = containerViewTransform.translatedBy(x: 0, y: self.view.frame.height - self.containerView.frame.origin.y - 100)
        self.containerView.transform = containerViewTransform
        self.containerToggled = !self.containerToggled
    }
    
    func drawLogo(){
        guard let accentColor = UIColor(named: "accentColor") else { return }
        let logoLayer = LogoLayer(for: logoView, scale: 1.1, duration: 0, lineWidth: 4, trackColor: accentColor, strokeColor: UIColor.white)
        self.view.layer.insertSublayer(logoLayer, below: self.logoView.layer)
    }
}
