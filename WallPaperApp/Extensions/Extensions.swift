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
        case alphaBlack
    }
    
   static func getAppColor(color: AppColor) -> UIColor? {
    if #available(iOS 11.0, *) {
        return UIColor(named: color.rawValue)
    } else {
       return getColorForIOS10(color: color)
    }
    }
    
    static func getColorForIOS10(color: AppColor) -> UIColor?{
        switch color {
        case .darkYellow:
            return UIColor(red: 236, green: 243, blue: 111, alpha: 1)
        
        case .lightYellow:
            return UIColor(red: 233, green: 205, blue: 21, alpha: 1)
        case .pink:
            return UIColor(red: 216, green: 27, blue: 96, alpha: 1)
        case .creem:
            return UIColor(red: 243, green: 238, blue: 238, alpha: 1)
        case .darkBlackBlue:
            return UIColor(red: 17, green: 34, blue: 51, alpha: 1)
        case .darkGray:
            return UIColor(red: 70, green: 70, blue: 70, alpha: 1)
        case .darkGreen:
            return UIColor(red: 6, green: 50, blue: 54, alpha: 1)
        case .alphaBlack:
            return UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 0.2)
        }
    }
}

extension UIFont{
    
    enum AppFont: String, CaseIterable{
        case abeezee
        case abrilFatface = "Abril Fatface"
        case aguafinaScript = "Aguafina Script"
        case aldrich = "Aldrich"
        case altMateyV2Black = "Alt Matey v2"
        case deliusSwashCaps = "Delius Swash Caps"
        case marckScript = "Marck Script"
        case outshineRegular = "Outshine"
        case pattaya = "Pattaya"
        case satisfy = "Satisfy"
        case spicyRice = "Spicy Rice"
        case tradeWinds = "Trade Winds"
    }
    
    static func getAppFont(font: AppFont, with size: Int = 13) -> UIFont?{
    
        return UIFont(name: font.rawValue, size: CGFloat(size))
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

