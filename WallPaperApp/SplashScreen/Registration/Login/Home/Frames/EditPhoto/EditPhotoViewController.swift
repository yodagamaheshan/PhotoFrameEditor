//
//  EditPhotoViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {
    
    
    @IBOutlet weak var editingAreaView: UIView!
    @IBOutlet weak var frameImageView: UIImageView!
    var currentImage: UIImage!
    var editedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    func setupViews(){
        frameImageView.layer.zPosition = 1
    }
    
    @IBAction func chooseImageButtonPressed(_ sender: Any) {
        let picker = UIImagePickerController()
        //TODO: change croping
        picker.allowsEditing = true
        picker.delegate = self
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        present(picker, animated: true)
    }
    
    @IBAction func backgroundColorButtonPressed(_ sender: Any) {
    }
    
    @IBAction func addTextButtonPressed(_ sender: Any) {
    }
    
    @IBAction func deleteImageButtonPresed(_ sender: Any) {
    }
    
    @IBAction func downloadImageButtonPressed(_ sender: Any) {
        editedImage = currentImage
        guard let image = editedImage else { return }

        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
   @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

}

extension EditPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        currentImage = image
        let imageView = UIImageView(image: currentImage)
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.red.cgColor
        imageView.frame = CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height)
        editingAreaView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        
        addGestures(to: imageView)
    }
    
    func addGestures(to imageView: UIImageView){
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.myPinchGesture))
        imageView.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(myPanGesture(sender:)))
        imageView.addGestureRecognizer(panGestureRecognizer)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapGesture(sender:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func myPinchGesture(sender: UIPinchGestureRecognizer){
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
    }
    
    @objc func myPanGesture(sender: UIPanGestureRecognizer){
    let translation = sender.translation(in: self.view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        
        sender.setTranslation(CGPoint.zero, in: self.view)
        
    }
    
     @objc func myTapGesture(sender: UITapGestureRecognizer){
        if let imageView = sender.view{
            editingAreaView.bringSubviewToFront(imageView)
        }
        
    }
}

