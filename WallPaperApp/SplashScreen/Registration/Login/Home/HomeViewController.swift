//
//  HomeViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var buttonCollection: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        for button in buttonCollection{
            button.styleWithRoundCorner(with: UIColor.getAppColor(color: .darkBlackBlue) ?? UIColor.black, filling: UIColor.getAppColor(color: .darkGray) ?? UIColor.gray)
        }
    }
}
