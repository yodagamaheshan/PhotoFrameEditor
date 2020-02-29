//
//  ColorPickerViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/29/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit
import WDColorPicker

class ColorPickerViewController: UIViewController, WDColorPickerViewDelegate {
    
    @IBOutlet weak var colorPicker: WDColorPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.colorPicker.delegate = self
        self.colorPicker.layer.backgroundColor = UIColor.black.cgColor
    }
    
    func colorChanged(colorPicker: WDColorPickerView, color: UIColor) {
        self.view.backgroundColor = color
    }
}
