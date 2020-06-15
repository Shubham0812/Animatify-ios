//
//  UIViewAnimations.swift
//  Animatify
//
//  Created by Shubham Singh on 14/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation
import UIKit


enum ViewAnimations {
    
    static func makeEaseInAnimation(duration: Double, delay: Double, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseIn, animations: {
            action()
        })
    }
    
    static func makeEaseInOutAnimation(duration: Double, delay: Double, action: @escaping() -> Void) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            action()
        })
    }
}
