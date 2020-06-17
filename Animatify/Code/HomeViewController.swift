//
//  HomeViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 14/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController{
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var effectsCollectionView: UICollectionView!
    
    var containerToggled: Bool = false {
        didSet {
            if (containerToggled) {
                self.containerView.roundCorners(cornerRadius: 20)
            } else {
                self.containerView.roundCorners(cornerRadius: 42)
            }
        }
    }
    
    override class func description() -> String {
        return "HomeViewController"
    }
    
    // hardcoding the tableView data for now
    var effects: [Effects] = [Effects](repeatElement(Effects(action: "", title: "Coming soon"), count: 4))
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
            
        self.effectsCollectionView.delegate = self
        self.effectsCollectionView.dataSource = self
        self.effectsCollectionView.register(UINib(nibName: EffectCollectionViewCell.description(), bundle: nil), forCellWithReuseIdentifier: EffectCollectionViewCell.description())
        self.view.bringSubviewToFront(containerView)
        
        self.setupViews()
        self.drawLogo()
    }
    
    // MARK:- outlets for the viewController
    @IBAction func expandButtonPressed(_ sender: Any) {
        ViewAnimationFactory.makeEaseInOutAnimation(duration: 0.75, delay: 0) {
            self.expandButton.transform = self.expandButton.transform.rotated(by: +CGFloat.pi + 0.00000001)
            var containerViewTransform = CGAffineTransform.identity
            containerViewTransform = containerViewTransform.translatedBy(x: 0, y: self.view.frame.height - self.containerView.frame.origin.y - 100)
            self.containerView.transform = containerViewTransform
            self.containerToggled = !self.containerToggled
        }
    }
    
    // MARK:- utility functions for the viewController
    func setupViews() {
        self.containerView.roundCorners(cornerRadius: 42)
        self.logoView.backgroundColor = UIColor.clear
        
        // set the section to collapsed
        self.expandButton.transform = self.expandButton.transform.rotated(by: +CGFloat.pi + 0.00000001)
        var containerViewTransform = CGAffineTransform.identity
        containerViewTransform = containerViewTransform.translatedBy(x: 0, y: self.view.frame.height - self.containerView.frame.origin.y - 100)
        self.containerView.transform = containerViewTransform
        self.containerToggled = !self.containerToggled
    }
    
    func drawLogo(){
        guard let accentColor = UIColor(named: "accentColor") else { return }
        let logoLayer = LogoLayer(for: logoView, scale: 1.1, duration: 0, lineWidth: 4, trackColor: accentColor, glideColor: UIColor.clear, strokeColor: UIColor.white)
        self.view.layer.insertSublayer(logoLayer, below: self.logoView.layer)
    }
}

// MARK:- Extension for CollectionView
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return effects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EffectCollectionViewCell.description(), for: indexPath) as? EffectCollectionViewCell {
            cell.setupCell(effect: effects[indexPath.item])
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2.5
             let collectionViewWidth = collectionView.bounds.width
             let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
             
             let adjustedWidth = (collectionViewWidth * 1.225) - (flowLayout.minimumLineSpacing * (columns - 1))
             let width = floor(adjustedWidth / columns)
        return CGSize(width: width, height: EffectCollectionViewCell().collectionViewHeight)
    }
}
