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
    
    
    // MARK:- variables for the viewController
    var maskingLayer = CALayer()
    var animationDuration: TimeInterval = 1
    var aspectRatio: Double = 0
    var ratioType: AspectRatioMode = .equal
    
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoImageView.isHidden.toggle()
        
        guard let image = logoImageView.image else { return }
        self.aspectRatio = self.calculateImageRatio(for: image)
        setMaskingLayer()
        
        self.view.layer.mask = maskingLayer
        self.view.bringSubviewToFront(overlayView)
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
        
        ViewAnimationFactory.makeEaseInAnimation(duration: animationDuration, delay: 0) {
            self.overlayView.layer.opacity = 0
        }
    }
    
    
    // MARK:- action outlets for the viewController
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK:- functions for the viewController
    func setMaskingLayer(){
        var imageWidth: Double = 180
        var imageHeight: Double = 180
        (imageWidth, imageHeight) = self.getFrameForImage(width: imageWidth, height: imageWidth)
        maskingLayer.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
        maskingLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        maskingLayer.position = view.center
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
