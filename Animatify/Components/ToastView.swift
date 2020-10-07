//
//  ToastView.swift
//  Animatify
//
//  Created by Carsten Przyluczky on 07.10.20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

struct ToastViewConfiguration {
    
    enum Theme {
        case light
        case dark
        
        var textColor: UIColor {
            switch self {
            case .light:
                return .black
            case .dark:
                return .white
            }
        }
    }
    
    enum ContentType {
        case success
        case info
        case warning
        
        var mainBackgroundColor: UIColor {
            switch self {
            case .success:
                return UIColor(red: 0.52, green: 0.93, blue: 0.68, alpha: 1)
            case .info:
                return .yellow
            case .warning:
                return .red
            }
        }

        var secondaryBackgroundColor: UIColor {
            switch self {
            case .success:
                return UIColor(red: 0.25, green: 0.89, blue: 0.50, alpha: 1)
            case .info:
                return .purple
            case .warning:
                return .purple
            }
        }
    }
    
    var title: String
    var caption: String?
    var theme: Theme
    var contentType: ContentType
    var duration: Double = 2
    var cornerRadius = CGFloat(5)
}

class ToastView: UIView {
    
    fileprivate var titleLabel = UILabel(frame: .zero)
    fileprivate var captionLabel = UILabel(frame: .zero)
    fileprivate var secondaryBackgroundView = UIView(frame: .zero)
    
    func show(on viewController: UIViewController, configuration: ToastViewConfiguration) {
        if superview != nil {
            removeFromSuperview()
        }
        if subviews.isEmpty {
            buildViewStructure()
        }
        
        viewController.view.addSubview(self)
        configure(with: configuration)
        fadeIn()
    }
    
    fileprivate func fadeIn() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = 1
        }
    }
    
    fileprivate func fadeOut() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.alpha = 0
        }
    }
}

// MARK: - Configuration -

fileprivate extension ToastView {
    
    func configure(with configuration: ToastViewConfiguration) {
        translatesAutoresizingMaskIntoConstraints = false
        alpha = 0
        configureMainBackground(with: configuration)
        configureSecondaryBackground(with: configuration)
        configureTitleLabel(with: configuration)
        configureCaptionLabel(with: configuration)
    }

    func configureMainBackground(with configuration: ToastViewConfiguration) {
        guard let parent = superview else {
            return
        }

        layer.cornerRadius = configuration.cornerRadius
        backgroundColor = configuration.contentType.mainBackgroundColor
        
        let bottomConstraint = NSLayoutConstraint(item: parent, attribute: .bottomMargin, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 10)
        let widthConstraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: parent, attribute: .width, multiplier: 0.8, constant: 0)
        let heightConstraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
        let centerConstraint = NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal, toItem: parent, attribute: .centerX, multiplier: 1, constant: 0)
        parent.addConstraints([bottomConstraint, widthConstraint, heightConstraint, centerConstraint])
    }
    
    func configureSecondaryBackground(with configuration: ToastViewConfiguration) {
        
        secondaryBackgroundView.layer.cornerRadius = configuration.cornerRadius
        secondaryBackgroundView.backgroundColor = configuration.contentType.secondaryBackgroundColor
        
        let widthConstraint = NSLayoutConstraint(item: secondaryBackgroundView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
        let leadingConstraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: secondaryBackgroundView, attribute: .leading, multiplier: 1, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: secondaryBackgroundView, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: secondaryBackgroundView, attribute: .bottom, multiplier: 1, constant: 0)
        addConstraints([widthConstraint, leadingConstraint, topConstraint, bottomConstraint])
    }
    
    func configureTitleLabel(with configuration: ToastViewConfiguration) {
        titleLabel.text = configuration.title
        titleLabel.textColor = configuration.theme.textColor
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        let leadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: secondaryBackgroundView, attribute: .trailing, multiplier: 1, constant: 10)
        let trailingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 10)
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 30)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }

    func configureCaptionLabel(with configuration: ToastViewConfiguration) {
        captionLabel.text = configuration.caption
        captionLabel.textColor = configuration.theme.textColor
        captionLabel.font = .systemFont(ofSize: 14)
        captionLabel.numberOfLines = 0
        
        let leadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: captionLabel, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: captionLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -10)
        let topConstraint = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: captionLabel, attribute: .bottom, multiplier: 1, constant: 20)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    func buildViewStructure() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        addSubview(captionLabel)
        addSubview(secondaryBackgroundView)
    }
}
