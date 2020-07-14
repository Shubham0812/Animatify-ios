//
//  Transitions.swift
//  Animatify
//
//  Created by Shubham Singh on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

enum TransitionType {
    case circular
    case expand
}

struct Transition {
    let title: String
    let action: TransitionType
    let difficulty: String
    let icon: String
}


struct Characters {
    let name: String
    let imageName: String
    let color: UIColor
}
