//
//  SnapCollectionViewCell.swift
//  Animatify
//
//  Created by Shubham Singh on 28/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class SnapCollectionViewCell: UICollectionViewCell {
    
    override class func description() -> String {
        return "SnapCollectionViewCell"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieDirectorLabel: UILabel!

    
    let collectionViewHeight: CGFloat = 320
    let collectionViewScale: CGFloat = 0.75
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.roundCorners(cornerRadius: 12)
        self.movieImageView.roundCorners(cornerRadius: 12)
        
        self.movieImageView.layer.borderColor = UIColor.white.cgColor
        self.movieImageView.layer.borderWidth = 2
    }
    
    override func prepareForReuse() {
        self.transform = CGAffineTransform(scaleX: collectionViewScale, y: collectionViewScale)
    }
    
    // MARK:- functions for the cell
    func setupCell(movie: Movie){
        self.movieImageView.image = UIImage(named: movie.movieImage)
        self.movieNameLabel.text = movie.movieName
        self.movieDirectorLabel.text = movie.movieDirector
        self.transform = CGAffineTransform(scaleX: collectionViewScale, y: collectionViewScale)
    }
    

}
