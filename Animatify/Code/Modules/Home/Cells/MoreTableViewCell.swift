//
//  MoreTableViewCell.swift
//  Animatify
//
//  Created by Fred Murakawa on 17/10/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class MoreTableViewCell: UITableViewCell {
    static let identifier: String = "MoreTableViewCell"
    
    let kPadding: CGFloat = 8
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont(name: "Montserrat-Regular", size: 16)
        return label
    }()
    
    private var view: UIView = UIView()
    
    func setupCell(text: String, view: UIView) {
        self.label.text = text
        self.view = view
        setupViews()        
    }
    
    private func setupViews() {
        backgroundColor = UIColor(named: "background")
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 6
        
        stackView.addArrangedSubview(view)
        stackView.addArrangedSubview(label)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: kPadding),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: kPadding),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -kPadding),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -kPadding),
            view.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
