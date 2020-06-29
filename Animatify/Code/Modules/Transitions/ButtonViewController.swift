//
//  ButtonViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class ButtonViewController: UIViewController {
    
    
    override class func description() -> String {
        return "ButtonViewController"
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var instructions: [String] = [
        "Create a UIViewControllerAnimatedTransitioning class.",
        "It has an animateTransition method where the animation between the viewController should be defined.",
        "After defining the class, UIViewControllerTransitioningDelegate has to be inherited by the viewController. ",
        "The delegate has 2 methods each for presenting and dissmissed viewController.",
    ]
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.setInstructions()
    }
    
    // MARK:- action outlets for the viewController
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    // MARK:- functions for the viewController
    func setInstructions(){        
        /// getting the initial value for the y axis
        var dy: CGFloat = self.instructionLabel.frame.origin.y + self.instructionLabel.frame.height + 24
        let stepLabelSize: CGFloat = 42
        
        for (ix,instruction) in instructions.enumerated() {
            let stepLabel = UILabel()
            stepLabel.font = UIFont(name: "MuseoModerno-Medium", size: 21)
            stepLabel.text = "\(ix + 1)"
            stepLabel.textAlignment = .center
            stepLabel.textColor = UIColor.white
            stepLabel.setBorderAndCorner(borderColor: UIColor.white, borderWidth: 2, cornerRadius: 21)
            stepLabel.frame = CGRect(x: 24, y: dy + stepLabel.intrinsicContentSize.height / 2, width: stepLabelSize, height: stepLabelSize)
            
            let descriptionLabel = UILabel()
            descriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 18)
            descriptionLabel.textColor = UIColor.white
            descriptionLabel.text = instruction
            descriptionLabel.numberOfLines = 5
            
            descriptionLabel.frame = CGRect(x: stepLabelSize * 2, y: dy + (descriptionLabel.intrinsicContentSize.height / 1.75), width: (self.view.frame.width - (24 * 3) - stepLabelSize), height: descriptionLabel.intrinsicContentSize.height)
            descriptionLabel.sizeToFit()
            
            dy += descriptionLabel.frame.size.height + 24
            // adding the labels to the scrollview
            self.view.addSubview(stepLabel)
            self.view.addSubview(descriptionLabel)
        }
    }
}
