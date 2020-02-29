//
//  ColorPickerViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/29/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit
import WDColorPicker

protocol ColorPickerViewControllerDelegate {
    func didSelectColor( color: UIColor)
}

class ColorPickerViewController: UIViewController, WDColorPickerViewDelegate {
    
    static func create() -> ColorPickerViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: ColorPickerViewController.self)) as? ColorPickerViewController
        return viewController!
    }
    
    @IBOutlet weak var pickerContainer: UIView!
    @IBOutlet weak var colorPicker: WDColorPickerView!
    var delegate: ColorPickerViewControllerDelegate?
    var initialColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorPicker.delegate = self
        setupViews()
    }
    
    func setupViews(){
        pickerContainer.layer.cornerRadius = 8
    }
    func colorChanged(colorPicker: WDColorPickerView, color: UIColor) {
        delegate?.didSelectColor(color: color)
    }
}
