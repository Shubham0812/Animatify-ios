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
                return UIColor(red: 0.99, green: 0.79, blue: 0.56, alpha: 1)
            case .warning:
                return UIColor(red: 0.96, green: 0.52, blue: 0.51, alpha: 1)
            }
        }

        var secondaryBackgroundColor: UIColor {
            switch self {
            case .success:
                return UIColor(red: 0.25, green: 0.89, blue: 0.50, alpha: 1)
            case .info:
                return UIColor(red: 0.98, green: 0.67, blue: 0.31, alpha: 1)
            case .warning:
                return UIColor(red: 0.93, green: 0.26, blue: 0.24, alpha: 1)
            }
        }
        
        var icon: UIImage? {
            switch self {
            case .success:
                return UIImage(systemName: "checkmark.circle.fill")
            case .info:
                return UIImage(systemName: "info.circle.fill")
            case .warning:
                return UIImage(systemName: "xmark.circle.fill")
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
    fileprivate var iconImageView = UIImageView(frame: .zero)
    
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
        startTimer(duration: configuration.duration)
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
    
    fileprivate func startTimer(duration: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.fadeOut()
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
        configureIconImageView(with: configuration)
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
    
    func configureIconImageView(with configuration: ToastViewConfiguration) {
        iconImageView.image = configuration.contentType.icon
        iconImageView.tintColor = configuration.theme.textColor
        
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: iconImageView, attribute: .trailing, multiplier: 1, constant: 20)
        let widthConstraint = NSLayoutConstraint(item: iconImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        let heightConstraint = NSLayoutConstraint(item: iconImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        let centerConstraint = NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: titleLabel, attribute: .centerY, multiplier: 1, constant: 0)
        addConstraints([trailingConstraint, widthConstraint, heightConstraint, centerConstraint])
    }
    
    func configureTitleLabel(with configuration: ToastViewConfiguration) {
        titleLabel.text = configuration.title
        titleLabel.textColor = configuration.theme.textColor
        titleLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        titleLabel.numberOfLines = 0
        
        let leadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: secondaryBackgroundView, attribute: .trailing, multiplier: 1, constant: 10)
        let trailingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: iconImageView, attribute: .trailing, multiplier: 1, constant: 10)
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 30)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint])
    }

    func configureCaptionLabel(with configuration: ToastViewConfiguration) {
        captionLabel.text = configuration.caption
        captionLabel.textColor = configuration.theme.textColor
        captionLabel.font = .systemFont(ofSize: 14)
        captionLabel.numberOfLines = 0
        
        let leadingConstraint = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: captionLabel, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: captionLabel, attribute: .trailing, multiplier: 1, constant: 10)
        let topConstraint = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 10)
        let bottomConstraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .greaterThanOrEqual, toItem: captionLabel, attribute: .bottom, multiplier: 1, constant: 20)
        addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
    
    func buildViewStructure() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        secondaryBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(captionLabel)
        addSubview(secondaryBackgroundView)
    }
}
