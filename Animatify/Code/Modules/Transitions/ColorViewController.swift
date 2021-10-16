//
//  ColorViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 11/02/21.
//  Copyright © 2021 Shubham Singh. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    // MARK:- outlets
    @IBOutlet weak var closeButton: UIButton!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteDescriptionLabel: UILabel!
    
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var closeButtonTop: NSLayoutConstraint!
    
    // MARK:- variables
    override class func description() -> String {
        return "ColorViewController"
    }
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY @ h:mm a"
        return dateFormatter
    }()
    
    var note: Note?
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async { [weak self] in
            self?.closeButton.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            self?.closeButton.layer.opacity = 0
            
            self?.setupData()
            
            if (UIScreen.main.bounds.height <= 736) {
                self?.closeButtonTop.constant = 44
            }
        }
        hideViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.2, delay: 0) {
                self.closeButton.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.closeButton.layer.opacity = 1
            }
            self.showViews()
        }
        print("NOTE ->", note)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.075, delay: 0) {
            self.dateView.layer.opacity = 0
        }
    }
    
    // MARK:- @objc funcs & IBActions
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    // MARK:- functions
    func hideViews() {
        self.titleLabel.layer.opacity = 0
        self.noteDescriptionLabel.layer.opacity = 0
    }
    
    func showViews() {
        ViewAnimationFactory.makeEaseOutAnimation(duration: 0.125, delay: 0) {
            self.titleLabel.layer.opacity = 1
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.2, delay: 0) {
                self.noteDescriptionLabel.layer.opacity = 1
            }
        }
    }
    
    func setupData() {
        guard let note = note else { return }
        self.titleLabel.text = note.title
        self.noteDescriptionLabel.text = note.content
        self.dateLabel.text = dateFormatter.string(from: note.lastUpdatedDate)
        
        DispatchQueue.main.async { [self] in
            let shadowView = UIView()
            shadowView.frame.origin.x = 24
            shadowView.frame.origin.y = titleLabel.frame.origin.y - 14
            
            shadowView.frame.size.width = self.view.frame.width - 48
            shadowView.frame.size.height = titleLabel.frame.height + 28 + noteDescriptionLabel.frame.height + 52
            
            shadowView.backgroundColor = UIColor.black.withAlphaComponent(0.075)
            shadowView.roundCorners(cornerRadius: 12)
            self.view.addSubview(shadowView)
            
        }
    }
}
