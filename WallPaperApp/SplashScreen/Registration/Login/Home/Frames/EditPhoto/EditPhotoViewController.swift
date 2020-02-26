//
//  EditPhotoViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var currentImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }
    
    
}

extension EditPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

        dismiss(animated: true)

        currentImage = image
        imageView.image = currentImage
    }
}
