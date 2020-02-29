//
//  EditPhotoViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class EditPhotoViewController: UIViewController {
    
    static func create() -> EditPhotoViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: EditPhotoViewController.self)) as? EditPhotoViewController
        return viewController!
    }

    
    @IBOutlet weak var editingAreaView: UIView!
    @IBOutlet weak var frameImageView: UIImageView!
    @IBOutlet weak var textEditingLayer: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var labelWidth: NSLayoutConstraint!
    
    var frameImage: UIImage?
    var currentlyEditingImage: UIView = UIView() {
        willSet{
            removeBorder(from: currentlyEditingImage)
        }
        didSet{
            addBorderTo(view: currentlyEditingImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(textPanned))
        textLabel.addGestureRecognizer(panGestureRecognizer)
        
        let pinchGuesterRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(textPinch))
        textLabel.addGestureRecognizer(pinchGuesterRecognizer)
    }
    
    func setupViews(){
        frameImageView.image = frameImage
        navigationController?.isNavigationBarHidden = true
        frameImageView.layer.zPosition = 1
        textLabel.layer.zPosition = 2
        labelWidth.constant = UIScreen.main.bounds.width
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
        let textInputVC = ColorPickerViewController.create()
        textInputVC.delegate = self
        present(textInputVC, animated: true, completion: nil)
    }
    
    @IBAction func addTextButtonPressed(_ sender: Any) {
        let textInputVC = TextInputViewController.create()
        textInputVC.delegate = self
        present(textInputVC, animated: true, completion: nil)

    }
    
    @IBAction func deleteImageButtonPresed(_ sender: Any) {
        currentlyEditingImage.removeFromSuperview()
    }
    
    @IBAction func downloadImageButtonPressed(_ sender: Any) {
        removeBorder(from: currentlyEditingImage)
        let renderer = UIGraphicsImageRenderer(size: editingAreaView.bounds.size)
        let image = renderer.image { ctx in
            editingAreaView.drawHierarchy(in: editingAreaView.bounds, afterScreenUpdates: true)
        }
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
        
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: (editingAreaView.center.x + editingAreaView.center.x/2), y: (editingAreaView.center.y - editingAreaView.center.y/2), width: imageView.bounds.size.width/5, height: imageView.bounds.size.height/5)
        imageView.center = editingAreaView.center
        imageView.contentMode = .scaleToFill
        currentlyEditingImage = imageView
        editingAreaView.addSubview(imageView)
        imageView.isUserInteractionEnabled = true
        
        addGestures(to: imageView)
    }
    
}

//MARK:images
extension EditPhotoViewController{
    func addBorderTo(view: UIView){
        let yourViewBorder = CAShapeLayer()
        yourViewBorder.strokeColor = UIColor.black.cgColor
        yourViewBorder.lineDashPattern = [15, 15]
        yourViewBorder.lineWidth = 5
        yourViewBorder.frame = view.bounds
        yourViewBorder.fillColor = nil
        yourViewBorder.path = UIBezierPath(rect: view.bounds).cgPath
        view.layer.addSublayer(yourViewBorder)
    }
    
    func removeBorder(from view: UIView){
        view.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func addGestures(to imageView: UIImageView){
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(self.myPinchGesture))
        imageView.addGestureRecognizer(pinchGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(myPanGesture(sender:)))
        imageView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(myTapGesture(sender:)))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        
        let rotationGesturRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(myRotationGesture(sender:)))
        imageView.addGestureRecognizer(rotationGesturRecognizer)
    }
    
    @objc func myPinchGesture(sender: UIPinchGestureRecognizer){
        if let imageView = sender.view{
            currentlyEditingImage = imageView
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
        }
    }
    
    @objc func myPanGesture(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: editingAreaView)
        if let imageView = sender.view {
            currentlyEditingImage = imageView
            imageView.center = CGPoint(x: imageView.center.x + translation.x, y: imageView.center.y + translation.y)
        }
        
        sender.setTranslation(CGPoint.zero, in: editingAreaView)
        
    }
    
    @objc func myTapGesture(sender: UITapGestureRecognizer){
        if let imageView = sender.view{
            currentlyEditingImage = imageView
            editingAreaView.bringSubviewToFront(imageView)
        }
    }
    
    @objc func myRotationGesture(sender: UIRotationGestureRecognizer){
        if let imageView = sender.view{
            currentlyEditingImage = imageView
            sender.view?.transform = (sender.view?.transform.rotated(by: sender.rotation))!
            sender.rotation = 0
        }
    }
}

//MARK: text
extension EditPhotoViewController{
    
    @objc func textPanned(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: editingAreaView)
        if let textView = sender.view {
            textView.center = CGPoint(x: textView.center.x + translation.x, y: textView.center.y + translation.y)
        }
        
        sender.setTranslation(CGPoint.zero, in: editingAreaView)
        
    }
    
    @objc func textPinch(sender: UIPinchGestureRecognizer){
        
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1
        
    }
    
}

//MARK: TextInput
extension EditPhotoViewController: TextInputViewControllerDelegate{
    func suerDidSelect(text: String, font: UIFont, color: UIColor?) {
        textLabel.text = text
        textLabel.font = font
        if color != nil{
            textLabel.textColor = color
        }
    }
}

//MARK: Color picker
extension EditPhotoViewController: ColorPickerViewControllerDelegate{
    func didSelectColor(color: UIColor) {
        editingAreaView.backgroundColor = color
    }
}
