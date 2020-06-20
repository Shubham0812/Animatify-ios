//
//  Effects.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation

struct Effects {
    let action: EffectType
    let title: String
    let description: String
}

enum EffectType {
    case pulse
    case shimmer
    case none
}
