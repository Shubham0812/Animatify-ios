//
//  CodeSymbolView.swift
//  Animatify
//
//  Created by Fred Murakawa on 16/10/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

final class CodeSymbolView: UIView {
    let kPadding: CGFloat = 0
    
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
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(leftChevronImageView)
        stackView.addArrangedSubview(rightChevronImageView)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.leadingAnchor, constant: kPadding),
            stackView.topAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.topAnchor, constant: kPadding),
            stackView.trailingAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.trailingAnchor, constant: -kPadding),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor, constant: -kPadding),
            stackView.widthAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 1.5)
        ])
    }
    
}
