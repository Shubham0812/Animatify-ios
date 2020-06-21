//
//  Tables.swift
//  Animatify
//
//  Created by Shubham Singh on 20/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

enum TableAnimation {
    case fadeIn(duration: TimeInterval, delay: TimeInterval)
    case moveUp(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpWithFade(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    case moveUpBounce(rowHeight: CGFloat, duration: TimeInterval, delay: TimeInterval)
    
    func getAnimation() -> TableCellAnimation {
        switch self {
        case .fadeIn(let duration, let delay):
            return TableAnimationFactory.makeFadeAnimation(duration: duration, delayFactor: delay)
        case .moveUp(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        case .moveUpWithFade(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpWithFadeAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
        case .moveUpBounce(let rowHeight, let duration, let delay):
            return TableAnimationFactory.makeMoveUpBounceAnimation(rowHeight: rowHeight, duration: duration, delayFactor: delay)
            
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .fadeIn(_, _):
            return "Fade-In Animation"
        case .moveUp(_, _, _):
            return "Move-Up Animation"
        case .moveUpWithFade(_, _, _):
            return "Move-Up-Fade Animation"
        case .moveUpBounce(_, _, _):
            return "Move-Up-Bounce Animation"
        }
    }
    
    func getDescription() -> String {
        switch self {
        case .fadeIn(_, _):
            return "Animating the tableView by increasing the opacity of the cells."
        case .moveUp(_, _, _):
            return "Animating the tableView by increasing the y-axis of the cells."
        case .moveUpWithFade(_, _, _):
            return "Animating the tableView by increasing the opacity and y-axis of the cells."
        case .moveUpBounce(_, _, _):
            return "Animating the tableView by increasing the y-axis of the cells with spring damping."
        }
    }
}
