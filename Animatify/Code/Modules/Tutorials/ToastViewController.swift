//
//  ToastViewController.swift
//  Animatify
//
//  Created by Carsten Przyluczky on 19.10.20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class ToastViewController: UIViewController {
    // MARK:- variables for the viewController
    override class func description() -> String {
        return "ToastViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    fileprivate func configure() {
        let infoButton = UIButton()
        infoButton.setTitle("Show info", for: .normal)
        infoButton.addTarget(self, action: #selector(infoButtonTouched), for: .touchUpInside)
        view.addSubview(infoButton)
        configure(button: infoButton)
        addCommonConstraints(to: infoButton)
        let topConstraint = NSLayoutConstraint(item: infoButton, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 10)
        view.addConstraint(topConstraint)
        
        let warningButton = UIButton()
        warningButton.setTitle("Show failed", for: .normal)
        warningButton.addTarget(self, action: #selector(warningButtonTouched), for: .touchUpInside)
        view.addSubview(warningButton)
        configure(button: warningButton)
        addCommonConstraints(to: warningButton)
        let horizontalConstraint1 = NSLayoutConstraint(item: warningButton, attribute: .top, relatedBy: .equal, toItem: infoButton , attribute: .bottom, multiplier: 1, constant: 10)
        view.addConstraint(horizontalConstraint1)

        let successButton = UIButton()
        successButton.setTitle("Show success", for: .normal)
        successButton.addTarget(self, action: #selector(successButtonTouched), for: .touchUpInside)
        view.addSubview(successButton)
        configure(button: successButton)
        addCommonConstraints(to: successButton)
        let horizontalConstraint2 = NSLayoutConstraint(item: successButton, attribute: .top, relatedBy: .equal, toItem: warningButton , attribute: .bottom, multiplier: 1, constant: 10)
        view.addConstraint(horizontalConstraint2)
    }
    
    fileprivate func addCommonConstraints(to button: UIButton) {
        let leadingConstraint = NSLayoutConstraint(item: button, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
        let trailingConstraint = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: button, attribute: .trailing, multiplier: 1, constant: 20)
        let heightConstraint = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
        view.addConstraints([leadingConstraint, trailingConstraint, heightConstraint])
    }
    
    fileprivate func configure(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = Colors.label.cgColor
        button.layer.cornerRadius = 5
        button.setTitleColor(Colors.label, for: .normal)
    }
    
    @objc func infoButtonTouched() {
        let toastView = ToastView()
        let configuration = ToastViewConfiguration(title: "Info", caption: "Some information.", theme: .dark, contentType: .info)
        toastView.show(on: self, configuration: configuration)
    }

    @objc func warningButtonTouched() {
        let toastView = ToastView()
        let configuration = ToastViewConfiguration(title: "Waring", caption: "Something could happen !", theme: .dark, contentType: .warning)
        toastView.show(on: self, configuration: configuration)
    }

    @objc func successButtonTouched() {
        let toastView = ToastView()
        let configuration = ToastViewConfiguration(title: "Success", caption: "OMG it works !", theme: .dark, contentType: .success)
        toastView.show(on: self, configuration: configuration)
    }
}
