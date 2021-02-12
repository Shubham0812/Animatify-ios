//
//  CircleViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class CircleViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    override class func description() -> String {
        return "CircleViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    // MARK:- variables for the viewController
    var circleAnimator: CircleAnimator?
    var selectedButton = UIButton()
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
    }
    
    // MARK:- UIViewControllerTrasitioningDelegates method
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let backgroundColor = selectedButton.backgroundColor else { return circleAnimator }
        circleAnimator = CircleAnimator(view: selectedButton, color: backgroundColor, duration: 0.3)
        circleAnimator?.mode = .dismiss
        return circleAnimator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let backgroundColor = selectedButton.backgroundColor else { return circleAnimator }
        circleAnimator = CircleAnimator(view: selectedButton, color: backgroundColor, duration: 0.2)
        circleAnimator?.mode = .present
        
        return circleAnimator
    }
    
    // MARK:- action outlets for the viewController
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func circleButtonPressed(_ sender: Any) {
        guard let buttonVC = self.storyboard?.instantiateViewController(identifier: ButtonViewController.description()) as? ButtonViewController,
            let senderButton = sender as? UIButton else { return }
        self.selectedButton = senderButton
        buttonVC.transitioningDelegate = self
        buttonVC.modalPresentationStyle = .custom
        self.present(buttonVC, animated: true, completion: nil)
    }
    

    // MARK:- utility functions for the viewController
    func setupViews() {
        self.button1.roundCorners(cornerRadius: button1.frame.size.width / 2.0)
        self.button2.roundCorners(cornerRadius: button2.frame.size.width / 2.0)
        self.button3.roundCorners(cornerRadius: button3.frame.size.width / 2.0)
        self.button4.roundCorners(cornerRadius: button4.frame.size.width / 2.0)
    }
}


