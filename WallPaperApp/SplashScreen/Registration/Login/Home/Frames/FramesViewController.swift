//
//  FramesViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit


struct Frame {
    let frameName: String
    let imageURL: String
    let unlock: Bool
}

class FramesViewController: UIViewController {
    @IBOutlet weak var frameCollectionView: UICollectionView!
    var frameCollection:[Frame] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameCollectionView.dataSource = self
        frameCollectionView.delegate = self
        frameCollectionView.register(UINib(nibName: String(describing: FrameCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FrameCollectionViewCell.self))
        
    }
    
}
extension FramesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return frameCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FrameCollectionViewCell.self), for: indexPath) as! FrameCollectionViewCell
        
        return cell
    }
    
    
}

extension FramesViewController: UICollectionViewDelegate{
    
}
