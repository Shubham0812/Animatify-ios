//
//  Tutorial.swift
//  Animatify
//
//  Created by Shubham Singh on 25/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import Foundation

enum TutorialType: Equatable {
    case tableViews
<<<<<<< HEAD:Animatify/Code/Models/Tutorials.swift
    case loaders(type : LoaderType)
    
    func getLoaderType() -> LoaderType? {
        switch self {
        case .tableViews:
            return nil
        case .loaders(type: let type):
            return type
        }
    }
}

enum LoaderType {
    case success
    case failure
=======
    case loaders
    case snapCollections
>>>>>>> upstream/dev:Animatify/Code/Models/Tutorial.swift
}

struct Tutorial {
    let action: TutorialType
    let title: String
    let difficulty: String
    let icon: String
}


struct Movie {
    let movieImage: String
    let movieName: String
    let movieDirector: String
}
