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
                    self.frameCollection.append( Frame(frameName: frame.key, imageURL: image["image"]!, unlock: image["unlock"]! == "yes" ? true:false))
                }
                self.frameCollectionView.reloadData()
            }
    }
    
}
extension FramesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FrameCollectionViewCell.self), for: indexPath) as! FrameCollectionViewCell
        cell.setPhotoFrame(frame: frameCollection[indexPath.row])
        return cell
    }
    
    
}

extension FramesViewController: UICollectionViewDelegate{
    
}

extension FramesViewController: UICollectionViewDelegateFlowLayout{
    //TODO: make frame collection like in photo app
      func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      //2
        let sectionInsets = UIEdgeInsets(top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
        
        let itemsPerRow = 2
      let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
      let availableWidth = view.frame.width - paddingSpace
      let widthPerItem = availableWidth / CGFloat(itemsPerRow)
      
      return CGSize(width: widthPerItem, height: widthPerItem)
    }

}

extension FramesViewController{
    
    func downloadAllImages(_ urls: [URL], completion: @escaping ([UIImage]) -> Void) {
        DispatchQueue.global(qos: .utility).async {
            let group = DispatchGroup()
            let semaphore = DispatchSemaphore(value: 4)
            var imageDictionary: [URL: UIImage] = [:]

            // download the images

            for url in urls {
                group.enter()
                semaphore.wait()

                self.download(url) { result in
                    defer {
                        semaphore.signal()
                        group.leave()
                    }

                    switch result {
                    case .failure(let error):
                        print(error)

                    case .success(let image):
                        DispatchQueue.main.async {
                            imageDictionary[url] = image
                        }
                    }
                }
            }

            // now sort the results

            group.notify(queue: .main) {
                completion(urls.compactMap { imageDictionary[$0] })
            }
        }
    }
    
    enum DownloadError: Error {
        case notImage
        case invalidStatusCode(URLResponse)
    }

    func download(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(error!))
                return
            }

            guard 200..<300 ~= response.statusCode else {
                completion(.failure(DownloadError.invalidStatusCode(response)))
                return
            }

            guard let image = UIImage(data: data) else {
                completion(.failure(DownloadError.notImage))
                return
            }

            completion(.success(image))
        }
    }
}
