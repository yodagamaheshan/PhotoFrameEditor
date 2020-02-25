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
    
    static func create() -> FogotPassWordViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: FogotPassWordViewController.self)) as? FogotPassWordViewController
        return viewController!
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        textFieldBackgrund.styleWithRoundCorner(with: UIColor.getAppColor(color: .creem) ?? UIColor.white, filling: UIColor.white)
        button.styleForRoundCorners()
    }
   
    @IBAction func resetPassword(_ sender: Any) {
        
        
    }
    
}
