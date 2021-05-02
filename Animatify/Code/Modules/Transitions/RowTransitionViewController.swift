//
//  RowTransitionViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 11/02/21.
//  Copyright © 2021 Shubham Singh. All rights reserved.
//

import UIKit

class RowTransitionViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    // MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    // MARK:- variables
    override class func description() -> String {
        return "RowTransitionViewController"
    }
    
    var selectedFrame: CGRect?
    var currentTableAnimation: TableAnimation = .moveUpWithFade(rowHeight: NoteTableViewCell().rowHeight, duration: 0.375, delay: 0.03)
    
    
    // MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(cell: NoteTableViewCell.self)
    }
    
    // MARK:- UIViewControllerTrasitioningDelegates method
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentAnimator = RowAnimator.animator
        presentAnimator.selectedFrame = selectedFrame!
        presentAnimator.transition = .dismiss
        return presentAnimator
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let presentAnimator = RowAnimator.animator
        presentAnimator.selectedFrame = self.selectedFrame!
        presentAnimator.animationOption = .curveEaseInOut
        presentAnimator.transition = .present
        return presentAnimator
    }
    
    // MARK:- @objc funcs & IBActions
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}

extension RowTransitionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return NoteTableViewCell().rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.description(), for: indexPath) as! NoteTableViewCell
        cell.setupCell(note: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCellFrame = tableView.cellForRow(at: indexPath)?.frame ?? CGRect()
        let openingFrame = tableView.convert(selectedCellFrame, to: tableView.superview)
        self.selectedFrame = openingFrame
        
        guard let colorVC = self.storyboard?.instantiateViewController(identifier: ColorViewController.description()) as? ColorViewController else { return }
        colorVC.note = notes[indexPath.row]
        colorVC.transitioningDelegate = self
        colorVC.modalPresentationStyle = .custom
        
        colorVC.view.backgroundColor = notes[indexPath.row].noteColor
        
        self.present(colorVC, animated: true, completion: nil)
    }
}
