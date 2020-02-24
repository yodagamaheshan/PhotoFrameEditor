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
    }
    
   static func getAppColor(color: AppColor) -> UIColor? {
        return UIColor(named: color.rawValue)
    }
}

extension UIFont{
    
}

extension UIViewController{
    func showAllert(with title: String = "Alert !", and message: String , defaultActionTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: defaultActionTitle, style: .default) { (action) in }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

