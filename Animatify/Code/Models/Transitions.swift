//
//  Transitions.swift
//  Animatify
//
//  Created by Shubham Singh on 29/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation


enum TransitionType {
    case circular
}

struct Transition {
    let title: String
    let action: TransitionType
    let difficulty: String
    let icon: String
}
