//
//  Extensions.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    enum AppColor: String {
        case darkYellow
        case lightYellow
        case pink
        case creem
        case darkBlackBlue
        case darkGray
        case darkGreen
    }
    
   static func getAppColor(color: AppColor) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}

extension UIFont{
    
    enum AppFont: String{
        case abeezee
        case abrilFatface = "abril_fatface"
        case aguafinaScript = "aguafina_script"
        case aldrich
        case altMateyV2Black = "alt_matey_v2_black"
        case deliusSwashCaps = "delius_swash_caps"
        case marckScript = "marck_script"
        case outshineRegular = "outshine_regular"
        case pattaya
        case satisfy
        case spicyRice = "spicy_rice"
        case tradeWinds = "trade_winds"
    }
    
    func getAppFont(font: AppFont) -> UIFont?{
        return UIFont(name: font.rawValue, size: 22)
    }
    
}

extension UIViewController{
    func showAllert(with title: String = "Alert !", and message: String , defaultActionTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: defaultActionTitle, style: .default) { (action) in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    func goTo(viewController: UIViewController){
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension UIView{
    
    func styleWithRoundCorner(with borderColor: UIColor,filling color: UIColor){
        self.layer.cornerRadius = self.frame.height/2
        self.backgroundColor = color
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
    }
    
    func styleForRoundCorners(){
                self.layer.cornerRadius = self.frame.height/2
    }
    
}

