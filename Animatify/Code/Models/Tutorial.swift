//
//  Tutorial.swift
//  Animatify
//
//  Created by Shubham Singh on 25/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation

enum LoaderType {
    case success
    case failure
    case bluetooth
    case wifi
}

enum TutorialAction: Equatable {
    case tableViews
    case loaders(type : LoaderType)
    case snapCollections
    case buttons

    
    func getLoaderType() -> LoaderType? {
        switch self {
        case .loaders(type: let type):
            return type
        default: return nil
        }
    }
}

enum ExpandDirection {
    case up
    case down
    case left
    case right
}

struct Tutorial {
    let action: TutorialAction
    let title: String
    let difficulty: String
    let icon: String
}


struct Movie {
    let movieImage: String
    let movieName: String
    let movieDirector: String
}
