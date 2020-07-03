//
//  CollectionTutorialViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 28/06/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit


class CollectionTutorialViewController: UIViewController {
    
    override class func description() -> String {
        return "CollectionTutorialViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK:- variables for the viewController
    private var collectionViewWidth: CGFloat = 0
    private var indexOfCellBeforeDragging = 0
    private var animationDuration = 0.25
    
    private var movies: [Movie] = [
        Movie(movieImage: "1", movieName: "Gravity", movieDirector: "Alfonso Cuarón"),
        Movie(movieImage: "2", movieName: "World War Z", movieDirector: "Marc Forster"),
        Movie(movieImage: "3", movieName: "The Godfather", movieDirector: "Francis Ford Coppola"),
        Movie(movieImage: "4", movieName: "Forrest Gump", movieDirector: "Robert Zemeckis"),
        Movie(movieImage: "5", movieName: "Inception", movieDirector: "Christopher Nolan"),
        Movie(movieImage: "6", movieName: "Shazam!", movieDirector: "David F. Sandberg"),
        Movie(movieImage: "7", movieName: "The Dark Knight Rises", movieDirector: "Christopher Nolan"),
    ]

    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// registering the collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: SnapCollectionViewCell.description(), bundle: nil), forCellWithReuseIdentifier: SnapCollectionViewCell.description())
        
        /// setting the collectionView to the secondCell
        DispatchQueue.main.async {
            let initialIndexPath = IndexPath(row: 1, section: 0)
            self.collectionView.scrollToItem(at: initialIndexPath, at: .centeredHorizontally, animated: false)
            let cell = self.collectionView.cellForItem(at: initialIndexPath)
            cell?.transform = CGAffineTransform.identity
        }
    }
    
    
    // MARK:- scrollViewDelegates for the viewController
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        indexOfCellBeforeDragging = indexOfCell()
        
        ViewAnimationFactory.makeEaseOutAnimation(duration: animationDuration, delay: 0) {
            let cell = self.collectionView.cellForItem(at: IndexPath(row: self.indexOfCellBeforeDragging, section: 0))
            cell?.transform = CGAffineTransform(scaleX: SnapCollectionViewCell().collectionViewScale, y: SnapCollectionViewCell().collectionViewScale)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        /// we do not handle the cell animation for a scroll here. If it's > 0.5 we delegate the cell animation to scrollViewDidEndDecelerating method.
        if (velocity.x  <= 0.5) {
            let indexPath = IndexPath(row: self.indexOfCell(), section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            
            ViewAnimationFactory.makeEaseOutAnimation(duration: animationDuration, delay: 0) {
                let cell = self.collectionView.cellForItem(at: indexPath) as? SnapCollectionViewCell
                cell?.transform = CGAffineTransform.identity
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let indexPath = IndexPath(row: self.indexOfCell(), section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let cell = collectionView.cellForItem(at: indexPath)
        let visibleCells = collectionView.visibleCells.filter({$0 != cell})
        visibleCells.forEach({$0.transform = CGAffineTransform(scaleX: SnapCollectionViewCell().collectionViewScale, y: SnapCollectionViewCell().collectionViewScale)})
        
        /// animate the cell in case of a long drag
        ViewAnimationFactory.makeEaseOutAnimation(duration: animationDuration, delay: 0) {
            let cell = self.collectionView.cellForItem(at: indexPath) as? SnapCollectionViewCell
            cell?.transform = CGAffineTransform.identity
        }
    }
    
    // MARK:- functions for the viewController
    func indexOfCell() -> Int {
        let cellWidth = collectionViewWidth
        let proportionalOffset = collectionView.contentOffset.x / cellWidth
        let index = Int(round(proportionalOffset))
        let numberOfItems = collectionView.numberOfItems(inSection: 0)
        let cellIndex = max(0, min(numberOfItems - 1, index))
        return cellIndex
    }
}

// MARK:- Extension for CollectionView
extension CollectionTutorialViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SnapCollectionViewCell.description(), for: indexPath) as? SnapCollectionViewCell {
            cell.setupCell(movie: movies[indexPath.row])
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 1.25
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let adjustedWidth = (collectionViewWidth * 0.9) - (flowLayout.minimumLineSpacing * (columns - 1))
        let width = floor(adjustedWidth / columns)
        self.collectionViewWidth = width
        return CGSize(width: width, height: SnapCollectionViewCell().collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}
