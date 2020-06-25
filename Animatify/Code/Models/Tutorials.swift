//
//  Tutorial.swift
//  Animatify
//
//  Created by Shubham Singh on 25/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation

enum TutorialType {
    case tableViews
    case loaders
}

struct Tutorials {
    let action: TutorialType
    let title: String
    let difficulty: String
    let icon: String
}
