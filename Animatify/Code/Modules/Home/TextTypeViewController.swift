//
//  TextTypeViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 14/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class TextTypeViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    override class func description() -> String {
        return "TextTypeViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var headerTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stepsView: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var hintTextContainerView: UIView!
    @IBOutlet weak var hintTextField: UITextField!
    
    
    // MARK:- variables for the viewController
    var scrollViewToggled: Bool = false {
        didSet {
            if (scrollViewToggled) {
                self.scrollView.roundCorners(cornerRadius: 32)
            } else {
                self.scrollView.roundCorners(cornerRadius: 20)
            }
        }
    }
    
    
    var effect: Effect?
    var typeDuration: TimeInterval = 0.0325
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        /// make sure there is no text in the textField / TextView
        self.headerTextField.text = ""
//        self.headerTextField.setGradientText(parent: self.view, color1: UIColor.systemPurple, color2: UIColor.systemPink)
        self.headerTextField.delegate = self
        
        self.descriptionTextView.text = ""
        self.descriptionTextView.delegate = self
        
        self.hintTextField.setGradientText(parent: self.hintTextContainerView, color1: UIColor(hex: "fa709a"), color2: UIColor(hex: "fee140"))
        self.hintTextField.layer.opacity = 0
        
        self.setupViews()
        self.expandButton.sendActions(for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let effect = effect else { return }
        
        /// don't forget to give the gradient colors if you want the textField / textView to have gradient
        self.headerTextField.typeOn(string: effect.title, typeInterval: typeDuration)
    }
    
    // MARK:- outlets for the viewController
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func expandButtonPressed(_ sender: Any) {
        ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.35, delay: 0) {
            self.expandButton.transform = self.expandButton.transform.rotated(by: +CGFloat.pi + 0.00000001)
            var containerViewTransform = CGAffineTransform.identity
            containerViewTransform = containerViewTransform.translatedBy(x: 0, y: self.view.frame.height - self.scrollView.frame.origin.y - 80)
            self.scrollView.transform = containerViewTransform
            self.scrollViewToggled = !self.scrollViewToggled
        }
    }
    
    
    // MARK:- textField Delegates
    func textFieldDidEndEditing(_ textField: UITextField) {
    guard let effect = effect else { return }
        self.descriptionTextView.typeOn(string: effect.description, typeInterval: typeDuration)
    }
    
    // MARK:- textViewDelegates Delegates
    func textViewDidEndEditing(_ textView: UITextView) {
        ViewAnimationFactory.makeEaseInAnimation(duration: 0.5, delay: 0) {
            self.hintTextField.layer.opacity = 1
        }
    }
    
    
    // MARK:- utility functions for the viewController
    
    func setupViews(){
        self.expandButton.transform = self.expandButton.transform.rotated(by: +CGFloat.pi + 0.00000001)
        var scrollViewTransform = CGAffineTransform.identity
        scrollViewTransform = scrollViewTransform.translatedBy(x: 0, y: self.view.frame.height - self.scrollView.frame.origin.y - 80)
        self.scrollView.transform = scrollViewTransform
        setInstructions()
    }
    
    
    func setInstructions(){
        guard let effect = self.effect else { return }
        
        /// getting the initial value for the y axis
        var dy: CGFloat = self.instructionsLabel.frame.origin.y + self.instructionsLabel.frame.height + 24
        let stepLabelSize: CGFloat = 42
        
        for (ix,instruction) in effect.instructions.enumerated() {
            let stepLabel = UILabel()
            stepLabel.font = UIFont(name: "MuseoModerno-Medium", size: 21)
            stepLabel.text = "\(ix + 1)"
            stepLabel.textAlignment = .center
            stepLabel.textColor = Colors.label
            stepLabel.setBorderAndCorner(borderColor: UIColor.systemTeal, borderWidth: 2, cornerRadius: 21)
            stepLabel.frame = CGRect(x: 24, y: dy + stepLabel.intrinsicContentSize.height / 2, width: stepLabelSize, height: stepLabelSize)
            
            let descriptionLabel = UILabel()
            descriptionLabel.font = UIFont(name: "Montserrat-Regular", size: 18.5)
            descriptionLabel.textColor = Colors.label
            descriptionLabel.text = instruction
            descriptionLabel.numberOfLines = 3
            
            descriptionLabel.frame = CGRect(x: stepLabelSize * 2, y: dy + (descriptionLabel.intrinsicContentSize.height / 1.75), width: (self.scrollView.frame.width - (24 * 3) - stepLabelSize), height: descriptionLabel.intrinsicContentSize.height)
            descriptionLabel.sizeToFit()
            
            dy += descriptionLabel.frame.size.height + 24
            // adding the labels to the scrollview
            self.stepsView.addSubview(stepLabel)
            self.stepsView.addSubview(descriptionLabel)
        }
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: dy + 72)
        }
    }
    
}
