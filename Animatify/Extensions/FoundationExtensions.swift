//
//  FoundationExtensions.swift
//  Animatify
//
//  Created by Shubham Singh on 27/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

extension CGFloat {
    func degreeToRadians() -> CGFloat {
        return (self * .pi) / 180
    }
}

extension Double {
    func roundToPlaces(places: Int) -> Double{
        let divisor = Double(truncating: NSDecimalNumber(decimal: pow(10, places)))
        return ((divisor * self).rounded() / divisor)
    }
}
