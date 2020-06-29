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
}

struct Tutorials {
    let action: TutorialType
    let title: String
    let difficulty: String
    let icon: String
}
