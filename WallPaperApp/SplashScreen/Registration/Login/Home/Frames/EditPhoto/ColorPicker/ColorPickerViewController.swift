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
    
    @IBOutlet weak var colorPicker: WDColorPickerView!
    var delegate: ColorPickerViewControllerDelegate?
    var initialColor: UIColor?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colorPicker.delegate = self
    }
    
    func colorChanged(colorPicker: WDColorPickerView, color: UIColor) {
        delegate?.didSelectColor(color: color)
    }
}
