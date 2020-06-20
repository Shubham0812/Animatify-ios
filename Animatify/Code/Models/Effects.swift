//
//  Effects.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

struct Effects {
    let action: EffectType
    let title: String
    let description: String
    let instructions: [String]
    let gradientColor1: UIColor
    let gradientColor2: UIColor
}

enum EffectType {
    case pulse
    case shimmer
    case none
}
