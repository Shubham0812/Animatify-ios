//
//  CodeSymbolView.swift
//  Animatify
//
//  Created by Fred Murakawa on 16/10/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class CodeSymbolView: UIView {
    
    private let leftChevronImageView: UIImageView
    private let rightChevronImageView: UIImageView

    init(color: UIColor, config: UIImage.SymbolConfiguration) {
        let leftChevronImage = UIImage(systemName: "chevron.left", withConfiguration: config)
        leftChevronImageView = UIImageView(image: leftChevronImage?.withTintColor(color, renderingMode: .alwaysOriginal))
        
        let rightChevronImage = UIImage(systemName: "chevron.right", withConfiguration: config)
        rightChevronImageView = UIImageView(image: rightChevronImage?.withTintColor(color, renderingMode: .alwaysOriginal))
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(leftChevronImageView)
        stackView.addArrangedSubview(rightChevronImageView)
        
        addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
