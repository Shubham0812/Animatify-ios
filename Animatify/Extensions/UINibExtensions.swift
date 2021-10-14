//
//  UINibExtensions.swift
//  Animatify
//
//  Created by Muiz on 02/05/21.
//  Copyright © 2021 Shubham Singh. All rights reserved.
//

import UIKit

protocol UINibInstantiable {
}
extension UINibInstantiable {
    static var nibName: String {
        "\(Self.self)"
    }
}

extension UINib {
    convenience init(for clazz: UINibInstantiable.Type) {
        self.init(nibName: "\(clazz.nibName)", bundle: nil)
    }
}

