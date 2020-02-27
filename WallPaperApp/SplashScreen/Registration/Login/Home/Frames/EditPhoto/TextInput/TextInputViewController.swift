//
//  TextInputViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/27/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class TextInputViewController: UIViewController {

    @IBOutlet weak var fontSizeTextField: UITextField!
    @IBOutlet weak var fontCollectionView: UICollectionView!
    @IBOutlet weak var textView: UITextView!
    
    var allFonts = UIFont.AppFont.allCases
    var isHiddenFontCollection: Bool = false{
        didSet{
            fontCollectionView.isHidden = isHiddenFontCollection
        }
    }
    var selectedFont: UIFont.AppFont = UIFont.AppFont.abeezee {
        didSet{
            setFontAndFontSize()
        }
    }
    var selectedFontSize: Int = 13{
        didSet{
            setFontAndFontSize()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        textView.delegate = self
        fontCollectionView.dataSource = self
        fontCollectionView.delegate = self
        fontCollectionView.register(UINib(nibName: String(describing: FontPreviewCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FontPreviewCollectionViewCell.self))
    }
    func setupViews(){
        textView.text = "Enter text..."
        textView.textColor = UIColor.lightGray
    }
    
    override func viewDidLayoutSubviews() {
        textView.centerVertically()
    }

    func setFontAndFontSize(){
        textView.font = UIFont.getAppFont(font: selectedFont, with: selectedFontSize)
        textView.centerVertically()
    }
    
    @IBAction func colorPickerButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func fotToggleButtonPressed(_ sender: Any) {
        isHiddenFontCollection.toggle()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
    }
 
    @IBAction func editingEnd(_ sender: UITextField) {
       print(sender.text)
    }
    @IBAction func editingChanged(_ sender: UITextField) {
        if let size = Int(sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""){
            selectedFontSize = size
        }
    }
    
}

extension TextInputViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allFonts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FontPreviewCollectionViewCell.self), for: indexPath) as! FontPreviewCollectionViewCell
        cell.setFont(font: allFonts[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedFont = allFonts[indexPath.row]
    }
    
}

extension TextInputViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter text..."
            textView.textColor = UIColor.lightGray
        }
    }

}
  extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

}
