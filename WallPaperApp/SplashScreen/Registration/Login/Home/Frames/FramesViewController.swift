//
//  FramesViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit
import FirebaseDatabase


struct Frame {
    let frameName: String
    let imageURL: String
    let unlock: Bool
    var isRequestSent: Bool
    var tappedOnce: Bool
    var image: UIImage?
}

class FramesViewController: UIViewController {
    @IBOutlet weak var frameCollectionView: UICollectionView!
    var frameCollection:[Frame] = []
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameCollectionView.dataSource = self
        frameCollectionView.delegate = self
        frameCollectionView.register(UINib(nibName: String(describing: FrameCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FrameCollectionViewCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        listenForFireBaseData()
    }
    
    func listenForFireBaseData(){
        ref = Database.database().reference().child("Birthday_Frames")
        ref.observe(.value) { (dataSnapshot) in
            
            let allFrames = dataSnapshot.value as! [String : Any]
            self.frameCollection.removeAll()
            for frame in allFrames{
                let image = frame.value as! [String:String]
                self.frameCollection.append( Frame(frameName: frame.key, imageURL: image["image"]!, unlock: image["unlock"]! == "yes" ? true:false, isRequestSent: false, tappedOnce: false))
            }
            
            // download images
            self.getData(frames: self.frameCollection) { (framesWithImages) in
                self.frameCollection = framesWithImages
                DispatchQueue.main.async {
                    self.frameCollectionView.reloadData()
                }
                
            }
        }
    }
    
    
    func getData(frames: [Frame],completion: @escaping ([Frame])-> Void ){
        var framesToDownload = frames
        var downloadedCount = 0
        
        for index in framesToDownload.indices{
            let frame = framesToDownload[index]
            URLSession.shared.dataTask(with: URL(string: frame.imageURL)!) { (data, response, error) in
                downloadedCount += 1
                
                if data != nil{
                    framesToDownload[index].image = UIImage(data: data!)
                }else{
                    framesToDownload[index].image = nil
                }
                if downloadedCount == framesToDownload.count{
                    completion(framesToDownload)
                }
            }.resume()
        }
        
    }
}
extension FramesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FrameCollectionViewCell.self), for: indexPath) as! FrameCollectionViewCell
        cell.setViewsForData(frame: frameCollection[indexPath.row], in:indexPath.row )
        cell.delegate = self
        return cell
    }
    
}

extension FramesViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        frameCollection[indexPath.row].tappedOnce = true
        frameCollectionView.reloadData()
    }
}

extension FramesViewController: UICollectionViewDelegateFlowLayout{
    //TODO: make frame collection like in photo app
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        //2
        let sectionInsets = UIEdgeInsets(top: 50.0,
                                         left: 10,
                                         bottom: 50.0,
                                         right: 20.0)
        
        let itemsPerRow = 2
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow)
        let availableWidth = view.frame.width
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
}

extension FramesViewController: FrameCollectionViewCellDelegate{
    func unlockButtonPressed(in row: Int) {
        showAllert(and: "Your request has been set to admin")
        if !frameCollection[row].isRequestSent{
            frameCollection[row].isRequestSent = true
            
        }
    }
}

