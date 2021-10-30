//
//  RowAnimator.swift
//  Animatify
//
//  Created by Shubham Singh on 11/02/21.
//  Copyright © 2021 Shubham Singh. All rights reserved.
//

import Foundation
import UIKit

class RowAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    static var animator = RowAnimator()
    
    /// enum for mode
    enum RowTransitionMode: Int {
        case present, dismiss
    }
    
    // MARK:- variables
    let presentationDuration: TimeInterval = 0.325
    let dismissDuration: TimeInterval = 0.2
    
    var selectedFrame: CGRect?
    var selectedColor: UIColor?
    
    var transition: RowTransitionMode = .present
    var animationOption: UIView.AnimationOptions!
    
    /// we need two views -> One that expands upwards and the other one downwards
    var topView: UIView!
    var bottomView: UIView!
    
    /// returns the duration for the transition
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if (transition == .present) {
            return presentationDuration
        } else {
            return dismissDuration
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        /// present
        guard let initialViewController = transitionContext.viewController(forKey: .from), let selectedFrame = selectedFrame, let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        let initialFrame = initialViewController.view.frame
        let containerView = transitionContext.containerView
        
        /// is the mode supplied by the viewcontroller is present
        if (transition == .present) {
            /// frame for the topView
            topView = initialViewController.view.resizableSnapshotView(from: initialFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets(top: selectedFrame.origin.y, left: 0, bottom: 0, right: 0))
            topView.frame = CGRect(x: 0, y: 0, width: initialFrame.width, height: initialFrame.origin.y)
            
            containerView.addSubview(topView)
            
            /// frame for the bottomView
            bottomView = initialViewController.view.resizableSnapshotView(from: initialFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets(top: 0, left: 0, bottom: initialFrame.height - selectedFrame.origin.y - selectedFrame.height, right: 0))
            bottomView.frame = CGRect(x: 0, y: selectedFrame.origin.y + selectedFrame.height, width: initialFrame.width, height: initialFrame.height - selectedFrame.origin.y - selectedFrame.height)
            
            containerView.addSubview(bottomView)
            
            /// take a snapshot and animate it during the transitionContext.
            let snapshotView = toViewController.view.resizableSnapshotView(from: initialFrame, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)!
            snapshotView.frame = selectedFrame
            
            containerView.addSubview(snapshotView)
            
            toViewController.view.alpha = 0.0
            containerView.addSubview(toViewController.view)
            
            /// animating the top and the bottom view
            UIView.animate(withDuration: presentationDuration, delay: 0, options: animationOption) {
                /// animate the views
                self.topView.frame = CGRect(x: 0, y: -self.topView.frame.height, width: self.topView.frame.width, height: self.topView.frame.height)
                
                snapshotView.frame = toViewController.view.frame
            } completion: { _ in
                snapshotView.removeFromSuperview()
                toViewController.view.alpha = 1.0
                
                /// finish the transition
                transitionContext.completeTransition(true)
            }
            
            /// bottom part goes first for a better view
            UIView.animate(withDuration: presentationDuration * 0.8, delay: 0, options: animationOption) {
                self.bottomView.frame = CGRect(x: 0, y: initialFrame.height, width: self.bottomView.frame.width, height: self.bottomView.frame.height)
            }
        } else {
            /// when the mode provided by the ViewController is in dismiss
            let snapshotView = initialViewController.view.resizableSnapshotView(from: initialViewController.view.bounds, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero)!
            containerView.addSubview(snapshotView)
            
            initialViewController.view.alpha = 0.0
            
            UIView.animate(withDuration: dismissDuration, delay: 0, options: .curveEaseIn) {
                self.topView.frame = CGRect(x: 0, y: 0, width: self.topView.frame.width, height: self.topView.frame.height)
                self.bottomView.frame = CGRect(x: 0, y: initialViewController.view.frame.height - self.bottomView.frame.height, width: self.bottomView.frame.width, height: self.bottomView.frame.height)
                snapshotView.frame = self.selectedFrame!
            } completion: { _ in
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
