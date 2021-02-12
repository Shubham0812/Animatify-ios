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
    case row
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

struct Note {
    let title: String
    let author: String
    let content: String
    let lastUpdatedDate: Date
    let noteColor: UIColor
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YY"
        return dateFormatter.string(from: lastUpdatedDate)
    }
}


let notes: [Note] = [
    Note(title: "Post Ideas", author: "Shubham", content: """
* Realm implementation / usage

* Animated Loader

* Swift Package

* Generic Network Manager
""", lastUpdatedDate: Date(timeIntervalSince1970: 1613050790), noteColor: UIColor(hex: "002855")),
    Note(title: "Important Links", author: "Shubham", content: """
* https://apple.github.io/swift-evolution

* https://www.hackingwithswift.com/learn

* https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps

* https://developer.apple.com/documentation/uikit/uibezierpath \n\n* https://heckj.github.io/swiftui-notes/

* https://www.epochconverter.com/

* https://www.swiftbysundell.com/articles/preventing-views-from-being-model-aware-in-swift/
""", lastUpdatedDate: Date(timeIntervalSince1970: 1612971590), noteColor: UIColor(hex: "845ec2")),
    
    Note(title: "Git commands", author: "Shubham", content: "∘ git bisect good ddfa3299420 \n\n∘ git cherry-pick f \n\n∘ git merge --squash \ngit rebase",
    lastUpdatedDate: Date(timeIntervalSince1970: 1612963430), noteColor: UIColor(hex: "1687a7")),
    Note(title: "Task Breakdown", author: "Shubham", content: "Base architecture", lastUpdatedDate: Date(timeIntervalSince1970: 1612877030), noteColor: UIColor(hex: "22333b")),
    Note(title: "Observations/Experiences", author: "Shubham", content: """
∘ It's generally a good practice to declare every variable and constants as private or fileprivate.

∘ Use @ObservedObject by defualt, change it into @StateObject if context has to be retained.

∘ Use default arguments and generic functions for Boxes and services.
"""
         , lastUpdatedDate: Date(timeIntervalSince1970: 1612833830), noteColor: UIColor(hex: "ef4f4f")),
    Note(title: "Code share", author: "Shubham", content: """
var path = Path()

path.move(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -18.5)))
path.addLine(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -35.17)))
path.addLine(to: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -35.17)))
path.addCurve(to: CGPoint(x: cX + (scale * -4.17),  y: cY + (scale * -47.67)), control1: CGPoint(x: cX + (scale * 8.33), y: cY + (scale * -42.07)), control2: CGPoint(x: cX + (scale *  2.74), y: cY + (scale * -47.67)))

path.addLine(to: CGPoint(x: cX + (scale * -20.83), y: cY + (scale * -10.17)))
path.addLine(to: CGPoint(x: cX + (scale * -20.83), y: cY + (scale * 35.67)))
path.addLine(to: CGPoint(x: cX + (scale * 26.17), y: cY + (scale * 35.67)))
path.addLine(to: CGPoint(x: cX + (scale * 26.12), y: cY + (scale * 35.67)))
"""
         , lastUpdatedDate: Date(timeIntervalSince1970: 1612791059), noteColor: UIColor(hex: "82B1FF")),
]
