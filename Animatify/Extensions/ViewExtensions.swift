//
//  ViewExtensions.swift
//  Animatify
//
//  Created by Shubham Singh on 14/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

extension UIView {
    
    /// For rounding the corners of the view
    func roundCorners(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}
