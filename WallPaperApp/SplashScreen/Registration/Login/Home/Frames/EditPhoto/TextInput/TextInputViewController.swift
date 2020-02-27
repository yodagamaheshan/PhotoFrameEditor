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
    var selectedFont: UIFont.AppFont = .deliusSwashCaps
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fontCollectionView.dataSource = self
        fontCollectionView.delegate = self
        fontCollectionView.register(UINib(nibName: String(describing: FontPreviewCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: FontPreviewCollectionViewCell.self))
    }
    
    override func viewDidLayoutSubviews() {
        textView.centerVertically()
    }

    @IBAction func colorPickerButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func fotToggleButtonPressed(_ sender: Any) {
        isHiddenFontCollection.toggle()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
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
