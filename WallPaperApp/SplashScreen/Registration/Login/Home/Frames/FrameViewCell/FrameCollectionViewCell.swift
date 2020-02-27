//
//  FrameCollectionViewCell.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/26/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class FrameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frameImage: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews(){
        unlockButton.layer.cornerRadius = 8
        unlockButton.backgroundColor = UIColor.getAppColor(color: .lightYellow)
    }

    @IBAction func unlockThisFrame(_ sender: Any) {
        
    }
    
}
