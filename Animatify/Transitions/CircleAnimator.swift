//
//  CircleAnimator.swift
//  Animatify
//
//  Created by Shubham Singh on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class CircleAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    enum TransitionMode {
        case present, dismiss
    }
    
    var transition: TransitionMode = .present
    
    var circle = UIView()
    var circleColor: UIColor
    
    var circleOrigin: CGPoint = CGPoint.zero
    
    var animationDuration: TimeInterval
    
    
    // MARK:- initializers for the circleAnimator
    init(view: UIView, color: UIColor, duration: TimeInterval) {
        self.circleOrigin = view.center
        self.circleColor = color
        self.animationDuration = duration
    }
    
    // MARK:- functions for the circleAnimator
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func frameForCircle(center: CGPoint, size: CGSize, start: CGPoint) -> CGRect{
        let lengthX = fmax(start.x, size.width - start.x)
        let lengthY = fmax(start.y, size.height - start.y)
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        if transition == .present {
            
            guard let presentedView = transitionContext.view(forKey: .to) else { return }
            let viewCenter = presentedView.center
            let viewSize = presentedView.frame.size
            
            circle = UIView(frame: frameForCircle(center: viewCenter, size: viewSize, start: circleOrigin))
            circle.roundCorners(cornerRadius: circle.frame.width / 2.0)
            circle.center = circleOrigin
            
            circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            circle.backgroundColor = circleColor
            
            containerView.addSubview(circle)
            
            presentedView.center = circleOrigin
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            presentedView.backgroundColor = circleColor
            
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
                self.circle.transform = CGAffineTransform.identity
                presentedView.transform = CGAffineTransform.identity
                presentedView.center = viewCenter
            }, completion: { (finished) in
                self.circle.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        } else {
            guard let returnController = transitionContext.view(forKey: .from) else { return }
            let viewCenter = returnController.center
            let viewSize = returnController.frame.size
            
            circle.frame = frameForCircle(center: viewCenter, size: viewSize, start: circleOrigin)
            circle.roundCorners(cornerRadius: circle.frame.width / 2.0)
            circle.center = circleOrigin
            circle.backgroundColor = circleColor
            
            
            containerView.addSubview(circle)
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseOut, animations: {
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
