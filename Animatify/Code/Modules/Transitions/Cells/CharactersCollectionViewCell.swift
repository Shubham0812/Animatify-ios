//
//  CharactersCollectionViewCell.swift
//  Animatify
//
//  Created by Shubham Singh on 14/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class CharactersCollectionViewCell: UICollectionViewCell, UINibInstantiable {
    
    override class func description() -> String {
        return "CharactersCollectionViewCell"
    }
    // MARK:- outlets for the viewController
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    
    let collectionViewHeight: CGFloat = 240
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 18
    }
    
    func setupCharacter(character: Characters) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            
            self.characterNameLabel.text = character.name
            self.imageView.image = UIImage(named: character.imageName)

            
            let gradient = CAGradientLayer()
            gradient.setGradientLayerWithLocation(color1: UIColor.clear, color2: character.color.withAlphaComponent(0.75), with: self.imageView.bounds, cornerRadius: self.layer.cornerRadius)
            self.imageView.layer.insertSublayer(gradient, below: self.layer)
        })
    }
    
}
