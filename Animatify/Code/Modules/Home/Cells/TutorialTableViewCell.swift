//
//  TutorialTableViewCell.swift
//  Animatify
//
//  Created by Shubham Singh on 19/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class TutorialTableViewCell: UITableViewCell {
    
    override class func description() -> String {
        return "TutorialTableViewCell"
    }
    
    // MARK:- outlets for the cell
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var tutorialLabel: UILabel!
    @IBOutlet weak var tutorialDifficulyLabel: UILabel!
    
    var tableViewHeight: CGFloat = 87
    var imageConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.backgroundColor = .clear
        iconButton.roundCorners(cornerRadius: iconButton.layer.frame.width / 2.0 - 3)
    }
    
    
    // MARK:- functions for the cell
    func setupTutorial(tutorial: Tutorial) {
        self.iconButton.setImage(UIImage(systemName: tutorial.icon, withConfiguration: imageConfiguration), for: .normal)
        self.tutorialLabel.text = tutorial.title
        self.tutorialDifficulyLabel.text = tutorial.difficulty
    }
    
    func setupTransition(transition: Transition) {
        self.iconButton.setImage(UIImage(systemName: transition.icon, withConfiguration: imageConfiguration), for: .normal)
        self.tutorialLabel.text = transition.title
        self.tutorialDifficulyLabel.text = transition.difficulty
    }
    
    
    
    func setDarkMode() {
        self.tutorialLabel.textColor = UIColor.white
        self.tutorialDifficulyLabel.textColor = UIColor.white
        self.iconButton.backgroundColor = Colors.accent.withAlphaComponent(0.25)
        self.iconButton.tintColor = UIColor.white
        
        self.containerView.backgroundColor = Colors.background
        self.backgroundColor = Colors.background
    }
}
