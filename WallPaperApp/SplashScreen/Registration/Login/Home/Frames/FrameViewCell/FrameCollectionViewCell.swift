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
    
    var photoFrame: Frame?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews(){
        unlockButton.layer.cornerRadius = 8
        unlockButton.backgroundColor = UIColor.getAppColor(color: .lightYellow)
    }
    
    func setPhotoFrame(frame:Frame){
        photoFrame = frame
        URLSession.shared.dataTask(with: URL(string: frame.imageURL)!) { (data, response, error) in
            if data != nil{
                DispatchQueue.main.async {
                    self.frameImage.image = UIImage(data: data!)
                }
            }
        }.resume()
     
    }
    
    @IBAction func unlockThisFrame(_ sender: Any) {
        
    }
    
}
