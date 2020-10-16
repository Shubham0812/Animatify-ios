//
//  ButtonsViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 03/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class ButtonEffectsViewController: UIViewController {
    
    // MARK:- variables for the viewController
    override class func description() -> String {
        return "ButtonEffectsViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var titleLabel: UILabel!
    
    private var collectionViewWidth: CGFloat = 0
    private var indexOfCellBeforeDragging = 0
    private var animationDuration = 0.25
    
    private var symbolNames = ["1.circle", "2.circle", "3.circle", "4.circle", "5.circle", "6.circle"]
    private var symbolTint = [UIColor.systemRed, UIColor.systemIndigo, UIColor.systemOrange, UIColor.systemGreen, UIColor.systemPink, UIColor.systemTeal]
    
    
    private var circleSymbolNames = ["calendar.circle", "flag.circle", "link.circle", "tag.circle", "bell.circle", "envelope.circle"]
    
    private var spacing: CGFloat = 20
    
    private var expandWidth: CGFloat = 300
    private var expandHeight: CGFloat = 300
    
    var upExpand = ExpandingButtonsView()
    var downExpand = ExpandingButtonsView()
    var rightExpand = ExpandingButtonsView()
    var leftExpand = ExpandingButtonsView()
    
    // MARK:- lifecycle methods for the viewController    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawButtons()
    }
    
    @IBAction func floatingButtonPressed(_ sender: Any) {
        guard let senderButton = sender as? UIButton else { return }
        print(senderButton.tag)
    }
    
    
    // MARK:- utility functions for the viewController
    func drawButtons() {
        
        /// rightExpand view
        self.rightExpand = ExpandingButtonsView(numberOfButtons: 3,
                                                symbolNames: symbolNames,
                                                symbolTint: symbolTint.shuffled(),
                                                expandDirection: .right,
                                                largeButtonSize: 46,
                                                smallButtonSize: 32)
        self.view.addSubview(rightExpand)
        self.rightExpand.translatesAutoresizingMaskIntoConstraints = false
        self.rightExpand.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spacing).isActive = true
        self.rightExpand.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: spacing).isActive = true
        self.rightExpand.widthAnchor.constraint(equalToConstant: self.rightExpand.expandedSize().width).isActive = true
        self.rightExpand.heightAnchor.constraint(equalToConstant: self.rightExpand.expandedSize().height).isActive = true
        
        /// leftExpand view
        self.leftExpand = ExpandingButtonsView(numberOfButtons: 2,
                                               symbolNames: symbolNames,
                                               symbolTint: symbolTint.shuffled(),
                                               expandDirection: .left,
                                               largeButtonSize: 46,
                                               smallButtonSize: 32)
        self.view.addSubview(leftExpand)
        self.leftExpand.translatesAutoresizingMaskIntoConstraints = false
        self.leftExpand.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -spacing).isActive = true
        self.leftExpand.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -spacing).isActive = true
        self.leftExpand.widthAnchor.constraint(equalToConstant: self.leftExpand.expandedSize().width).isActive = true
        self.leftExpand.heightAnchor.constraint(equalToConstant: self.leftExpand.expandedSize().height).isActive = true
        
        /// topExpand view
        self.upExpand = ExpandingButtonsView(numberOfButtons: 4,
                                             symbolNames: circleSymbolNames.shuffled(),
                                             symbolTint: symbolTint.shuffled(),
                                             expandDirection: .up,
                                             largeButtonSize: 46,
                                             smallButtonSize: 32)
        self.view.addSubview(upExpand)
        self.upExpand.translatesAutoresizingMaskIntoConstraints = false
        self.upExpand.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spacing).isActive = true
        self.upExpand.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -spacing).isActive = true
        self.upExpand.widthAnchor.constraint(equalToConstant: self.upExpand.expandedSize().width).isActive = true
        self.upExpand.heightAnchor.constraint(equalToConstant: self.upExpand.expandedSize().height).isActive = true
        
        /// downExpand view
        self.downExpand = ExpandingButtonsView(numberOfButtons: 6,
                                               symbolNames: circleSymbolNames.shuffled(),
                                               symbolTint: symbolTint.shuffled(),
                                               expandDirection: .down,
                                               largeButtonSize: 46,
                                               smallButtonSize: 32)
        self.view.addSubview(downExpand)
        self.downExpand.translatesAutoresizingMaskIntoConstraints = false
        self.downExpand.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -spacing).isActive = true
        self.downExpand.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: spacing).isActive = true
        self.downExpand.widthAnchor.constraint(equalToConstant: self.downExpand.expandedSize().width).isActive = true
        self.downExpand.heightAnchor.constraint(equalToConstant: self.downExpand.expandedSize().height).isActive = true
    }
}
