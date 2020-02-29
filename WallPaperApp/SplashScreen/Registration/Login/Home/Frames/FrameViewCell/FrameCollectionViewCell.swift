//
//  FrameCollectionViewCell.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/26/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

protocol FrameCollectionViewCellDelegate{
    func unlockButtonPressed(in row: Int)
}

class FrameCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frameImage: UIImageView!
    @IBOutlet weak var unlockButton: UIButton!
    
    var photoFrame: Frame?
    var rowNumber: Int!
    var delegate: FrameCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews(){
        unlockButton.layer.cornerRadius = 8
        unlockButton.backgroundColor = UIColor.getAppColor(color: .lightYellow)
    }
    
//    struct Frame {
//        let frameName: String
//        let imageURL: String
//        let unlock: Bool
//        var isRequestSent: Bool
//        var tappedOnce: Bool
//        var image: UIImage?
//    }
    
    func setViewsForData(frame: Frame, in row: Int){
        rowNumber = row
        
        if let image = frame.image{
            frameImage.image = image
        }
        
        if frame.tappedOnce, !frame.unlock{
            unlockButton.isHidden = false
        }
        if frame.isRequestSent{
            unlockButton.titleLabel?.text = "Request Sent"
        }
    }
    
    override func prepareForReuse() {
        unlockButton.isHidden = true
        unlockButton.titleLabel?.text = "Unlock This Frame"
    }
    
    @IBAction func unlockThisFrame(_ sender: Any) {
        delegate?.unlockButtonPressed(in: rowNumber)
    }
    
}
