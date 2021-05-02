//
//  CharactersViewController.swift
//  Animatify
//
//  Created by Shubham Singh on 14/07/20.
//  Copyright © 2020 Shubham Singh. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    override class func description() -> String {
        return "CharactersViewController"
    }
    
    // MARK:- outlets for the viewController
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    var characters: [Characters] = [
        Characters(name: "Naruto", imageName: "naruto", color: UIColor(hex: "ffea00")),
        Characters(name: "Sasuke", imageName: "sasuke", color: UIColor(hex: "651fff")),
        Characters(name: "Itachi", imageName: "itachi", color: UIColor(hex: "ff1744")),
        Characters(name: "Pain", imageName: "pain", color: UIColor(hex: "ff3d00")),
    ]
    
    // MARK:- lifecycle methods for the viewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.characterCollectionView.delegate = self
        self.characterCollectionView.dataSource = self
        self.characterCollectionView.register(UINib(for: CharactersCollectionViewCell.self), forCellWithReuseIdentifier: CharactersCollectionViewCell.description())
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension CharactersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharactersCollectionViewCell.description(), for: indexPath) as? CharactersCollectionViewCell {
            cell.setupCharacter(character: self.characters[indexPath.item])
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let adjustedWidth = (collectionViewWidth * 1) - (flowLayout.minimumInteritemSpacing * (columns - 1))
        let width = floor(adjustedWidth / columns)
        return CGSize(width: width, height: CharactersCollectionViewCell().collectionViewHeight)
    }
    
    func  collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let expandVC = self.storyboard?.instantiateViewController(identifier: IntroExpandViewController.description()) as? IntroExpandViewController else { return }
        expandVC.modalPresentationStyle = .fullScreen
        expandVC.modalTransitionStyle = .crossDissolve
        expandVC.character = self.characters[indexPath.item]
        self.present(expandVC, animated: true)
    }
}
