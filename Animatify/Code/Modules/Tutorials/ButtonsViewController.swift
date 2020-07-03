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
    
    private var dX: CGFloat = 20
    private var dY: CGFloat = 0
    
    private var spacing: CGFloat = 56
    
    private var expandWidth: CGFloat = 300
    private var expandHeight: CGFloat = 300
    
    var upExpand = ExpandingButtonsView()
    var downExpand = ExpandingButtonsView()
    var rightExpand = ExpandingButtonsView()
    var leftExpand = ExpandingButtonsView()
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dY = titleLabel.frame.origin.x + titleLabel.frame.height + spacing
        drawButtons()
    }
    
    @IBAction func floatingButtonPressed(_ sender: Any) {
        guard let senderButton = sender as? UIButton else { return }
        print(senderButton.tag)
    }
    
    
    // MARK:- utility functions for the viewController
    func drawButtons() {
        /// rightExpand view
        self.rightExpand = ExpandingButtonsView(frame: CGRect(x: dX, y: dY, width: expandWidth, height: expandHeight), numberOfButtons: 3, symbolNames: symbolNames, symbolTint: symbolTint.shuffled(), expandDirection: .right, largeButtonSize: 46, smallButtonSize: 32)
        self.view.addSubview(rightExpand)
        
        
        /// leftExpand view
        self.leftExpand = ExpandingButtonsView(frame: CGRect(x: self.view.frame.width  - (expandWidth + spacing / 2), y: self.view.frame.height - (expandHeight / 2) - (spacing / 1.45), width: expandWidth, height: expandHeight), numberOfButtons: 2, symbolNames: symbolNames, symbolTint: symbolTint.shuffled(), expandDirection: .left,  largeButtonSize: 46, smallButtonSize: 32)
        self.view.addSubview(leftExpand)
        
        /// topExpand view
        self.upExpand = ExpandingButtonsView(frame: CGRect(x: dX, y: self.view.frame.height - (expandHeight / 1.15), width: expandWidth / 4, height: expandHeight / 2), numberOfButtons: 4, symbolNames: circleSymbolNames.shuffled(), symbolTint: symbolTint.shuffled(), expandDirection: .up,  largeButtonSize: 46, smallButtonSize: 32)
        self.view.addSubview(upExpand)
        
        /// downExpand view
        self.downExpand = ExpandingButtonsView(frame: CGRect(x: self.view.frame.width - expandWidth / 2.1, y: dY, width: expandWidth / 2, height: expandHeight), numberOfButtons: 6, symbolNames: circleSymbolNames.shuffled(), symbolTint: symbolTint.shuffled(), expandDirection: .down,  largeButtonSize: 46, smallButtonSize: 32)
        self.view.addSubview(downExpand)
        
    }
}
