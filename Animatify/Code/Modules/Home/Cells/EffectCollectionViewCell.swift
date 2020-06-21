//
//  EffectCollectionViewCell.swift
//  Animatify
//
//  Created by Shubham Singh on 17/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class EffectCollectionViewCell: UICollectionViewCell {
    
    override class func description() -> String {
        return "EffectCollectionViewCell"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var collectionViewHeight: CGFloat = 180
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView.roundCorners(cornerRadius: 12)
    }
    
    func setupCell(effect: Effects){
        self.titleLabel.text = effect.title
        ///add the gradient to the view
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            let gradient = CAGradientLayer()
            gradient.setGradientLayer(color1: effect.gradientColor1,color2: effect.gradientColor2, for: self.containerView, cornerRadius: self.containerView.layer.cornerRadius)
            self.containerView.layer.addSublayer(gradient)
            
        }
    }
    
}
