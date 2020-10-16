//
//  TableAnimationViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 20/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class TableAnimationViewController: UIViewController {
    
    override class func description() -> String {
        return "TableAnimationViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK:- variables for the viewController
    var colors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemOrange, UIColor.systemPurple,UIColor.systemGreen]
    var tableViewHeaderText = ""
    var animationDuration: TimeInterval = 0.85
    var delay: TimeInterval = 0.05
    var fontSize: CGFloat = 26
    var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.85, delay: 0.03) {
        didSet{
            self.tableViewHeaderText = currentTableAnimation.getTitle()
            self.descriptionLabel.text = currentTableAnimation.getDescription()
        }
    }
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        colors.append(contentsOf: colors[0..<4])
        
        // registering the tableView
        self.tableView.register(UINib(nibName: TableAnimationViewCell.description(), bundle: nil), forCellReuseIdentifier: TableAnimationViewCell.description())
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
        self.tableViewHeaderText = self.currentTableAnimation.getTitle()
        self.descriptionLabel.text = currentTableAnimation.getDescription()

        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
    // MARK:- outlets for the viewController
    @IBAction func animationButtonPressed(_ sender: Any) {
        guard let senderButton = sender as? UIButton else { return }
        
        button1.setImage(UIImage(systemName: "1.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        button2.setImage(UIImage(systemName: "2.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        button3.setImage(UIImage(systemName: "3.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        button4.setImage(UIImage(systemName: "4.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        
        switch senderButton.tag {
        case 1: senderButton.setImage(UIImage(systemName: "1.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        currentTableAnimation = TableAnimation.fadeIn(duration: animationDuration, delay: delay)
        case 2: senderButton.setImage(UIImage(systemName: "2.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        currentTableAnimation = TableAnimation.moveUp(rowHeight: TutorialTableViewCell().tableViewHeight, duration: animationDuration, delay: delay)
        case 3: senderButton.setImage(UIImage(systemName: "3.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: TutorialTableViewCell().tableViewHeight, duration: animationDuration, delay: delay)
        case 4: senderButton.setImage(UIImage(systemName: "4.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: fontSize, weight: .semibold, scale: .large)), for: .normal)
        currentTableAnimation = TableAnimation.moveUpBounce(rowHeight: TutorialTableViewCell().tableViewHeight, duration: animationDuration + 0.2, delay: delay)
        default: break
        }
        
        self.tableView.reloadData()
    }
}

// MARK:- Extension for TableView
extension TableAnimationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableAnimationViewCell().tableViewHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TableAnimationViewCell.description(), for: indexPath) as? TableAnimationViewCell {
            cell.color = colors[indexPath.row]
            return cell
        }
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 42))
        headerView.backgroundColor = Colors.background
        let label = UILabel()
        label.frame = CGRect(x: 24, y: 12, width: self.view.frame.width, height: 42)
        label.text = tableViewHeaderText
        label.textColor = Colors.label
        label.font = UIFont(name: "Raleway-SemiBold", size: 24)
        headerView.addSubview(label)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
}



