//
//  FontPreviewCollectionViewCell.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/27/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class FontPreviewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setFont(font: UIFont.AppFont){
        if let font = UIFont.getAppFont(font: font){
            nameLabel.font = font
        }
    }

}
