//
//  CircleAnimator.swift
//  Animatify
//
//  Created by Shubham Singh on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class CircleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    /// enum for mode
    enum TransitionMode {
        case present, dismiss
    }
    
    // MARK:- variables
    /// initialising the default enum mode to presentation
    var mode: TransitionMode = .present
    
    /// UIView that animates as a part of the transition View
    var circle = UIView()
    var circleColor: UIColor
    
    /// default origin for the UIView
    var circleOrigin: CGPoint = CGPoint.zero
    var animationDuration: TimeInterval
    
    
    // MARK:- initializers
    init(view: UIView, color: UIColor, duration: TimeInterval) {
        self.circleOrigin = view.center
        self.circleColor = color
        self.animationDuration = duration
    }
    
    // MARK:- functions
    
    /// returns the duration for the transition
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    /// returns the frame the circle is supposed to occupy while transitioning
    func frameForCircle(center: CGPoint, size: CGSize, start: CGPoint) -> CGRect {
        /// fetching the maximum length of the parent view
        let lengthX = fmax(start.x, size.width - start.x)
        let lengthY = fmax(start.y, size.height - start.y)
        
        
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    /// the function for transitioning between the viewControllers
    /// the container View is the intermediate view between the presenting and the presented view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        /// is the mode supplied by the viewcontroller is present
        if mode == .present {
            guard let presentedView = transitionContext.view(forKey: .to) else { return }
            let viewCenter = presentedView.center
            let viewSize = presentedView.frame.size
            
            /// set a circle in place of the selectedButton
            circle = UIView(frame: frameForCircle(center: viewCenter, size: viewSize, start: circleOrigin))
            circle.roundCorners(cornerRadius: circle.frame.width / 2.0)
            circle.center = circleOrigin
            
            /// make the circle small so that we can animate
            circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            circle.backgroundColor = circleColor
            
            /// container view is where the action transition takes place
            containerView.addSubview(circle)
            
            /// presentedView is the view we will transition to
            presentedView.center = circleOrigin
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            presentedView.backgroundColor = circleColor
            
            /// add the presentedView to container so that we can animate it too
            containerView.addSubview(presentedView)
            
            /// animate the circle and the presentedView and remove it after completion
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.circle.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                presentedView.center = viewCenter
            }, completion: { (finished) in
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        } else {
            /// if the mode provided by the viewController is in dismiss
            guard let returnController = transitionContext.view(forKey: .from) else { return }
            let viewCenter = returnController.center
            let viewSize = returnController.frame.size
            
            /// set a circle in place of the selectedButton
            circle.frame = frameForCircle(center: viewCenter, size: viewSize, start: circleOrigin)
            circle.roundCorners(cornerRadius: circle.frame.width / 2.0)
            circle.center = circleOrigin
            circle.backgroundColor = circleColor
            
            /// container view is where the action transition takes place
            containerView.addSubview(circle)
            
            /// animate the circle and the returningController and remove it after completion
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
                self.circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returnController.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returnController.center = self.circleOrigin
                returnController.alpha = 0
                
            }, completion: {finished in
                returnController.removeFromSuperview()
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
    }
}
