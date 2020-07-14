//
//  IntroExpandViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 14/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

enum AspectRatioMode {
    case width
    case height
    case equal
}

class IntroExpandViewController: UIViewController, CAAnimationDelegate {
    
    override class func description() -> String {
        return "IntroExpandViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var overlayView: UIView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    
    // MARK:- variables for the viewController
    var maskingLayer = CALayer()
    var animationDuration: TimeInterval = 1
    var aspectRatio: Double = 0
    var ratioType: AspectRatioMode = .equal

    var instructions: [String] = [
         "Converts the supplied Image into a Core Graphics Image.",
         "Creates a mask with the contents of the Image and applies it to the view.",
         "Adds an overlay to the View and then animate them."
     ]
    
    var character: Characters?
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let character = self.character {
            self.overlayView.backgroundColor = character.color.withAlphaComponent(0.85)
            self.logoImageView.image = UIImage(named: character.imageName)
            self.logoImageView.isHidden.toggle()
            
            setMaskingLayer()
            setInstructions()
            self.view.bringSubviewToFront(overlayView)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() - 1, execute: {
            guard let image = self.logoImageView.image else { return }
            self.maskingLayer.contents = image.cgImage
            self.animateMask()
        })
    }
    
    // MARK:- Delegate for the CABasicAnimation
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        var imageWidth: Double = 4000
        var imageHeight: Double = 4000
        (imageWidth, imageHeight) = self.getFrameForImage(width: imageWidth, height: imageWidth)
        
        let toFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        let increaseAnimation = LayerAnimationFactory.getBoundsAnimation(duration: animationDuration, fromValue: maskingLayer.bounds, toValue: toFrame)
        self.maskingLayer.add(increaseAnimation, forKey: "animIncrease")
        
        ViewAnimationFactory.makeEaseInAnimation(duration: animationDuration / 1.25, delay: 0) {
            self.overlayView.layer.opacity = 0
        }
    }
    
    
    // MARK:- action outlets for the viewController
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK:- functions for the viewController
    func setMaskingLayer() {
        
        guard let image = logoImageView.image else { return }
        self.aspectRatio = self.calculateImageRatio(for: image)
        var imageWidth: Double = 180
        var imageHeight: Double = 180
        (imageWidth, imageHeight) = self.getFrameForImage(width: imageWidth, height: imageWidth)
        maskingLayer.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        maskingLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        maskingLayer.position = view.center
        self.view.layer.mask = maskingLayer
    }
    
    func animateMask() {
        var imageWidth: Double = 140
        var imageHeight: Double = 140
        
        (imageWidth, imageHeight) = self.getFrameForImage(width: imageWidth, height: imageWidth)
        let toFrame = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        let decreaseAnimation = LayerAnimationFactory.getBoundsAnimation(duration: animationDuration / 2.5, fromValue: maskingLayer.bounds, toValue: toFrame)
        decreaseAnimation.delegate = self
        self.maskingLayer.add(decreaseAnimation, forKey: "animDecrease")
    }
    
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
    
    
    // MARK:- utility functions for the viewController
    /// function to calculate the ratio for the image
    func calculateImageRatio(for image: UIImage) -> Double {
        let width: Double = image.size.width.toDouble()
        let height: Double = image.size.height.toDouble()
        if (width > height) {
            self.ratioType = .width
            return (width / height).roundToPlaces(places: 3)
        } else if (height > width) {
            self.ratioType = .height
            return (height / width).roundToPlaces(places: 3)
        } else {
            return 1
        }
    }
    
    /// get the width & height for the image based on the aspect ratio
    func getFrameForImage(width: Double, height: Double) -> (Double, Double) {
        if (self.ratioType == .height) {
            return (width, height * aspectRatio)
        } else if (self.ratioType == .width) {
            return (height, width * aspectRatio)
        } else {
            return (width, height)
        }
    }
}
