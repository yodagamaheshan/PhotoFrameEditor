//
//  FogotPassWordViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class FogotPassWordViewController: UIViewController {
    @IBOutlet weak var textFieldBackgrund: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        textFieldBackgrund.styleForTextFieldBackground()
        button.styleForRoundCorners()
    }
   
    @IBAction func resetPassword(_ sender: Any) {
        
        
    }
    
}
