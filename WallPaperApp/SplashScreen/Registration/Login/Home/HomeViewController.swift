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
    
    static func create() -> HomeViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: HomeViewController.self)) as? HomeViewController
        return viewController!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        for button in buttonCollection{
            button.styleWithRoundCorner(with: UIColor.getAppColor(color: .darkBlackBlue) ?? UIColor.black, filling: UIColor.getAppColor(color: .darkGray) ?? UIColor.gray)
        }
    }
    
    @IBAction func onLinkPressed(_ sender: Any) {
        if let url = URL(string: "https://yourphotoonit.com/pages/signup-wallpaper") {
            UIApplication.shared.open(url)
        }
    }
    
    @IBAction func shareButtonPressed(_ sender: Any) {
        let items = [URL(string: "https://www.apple.com")!]
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)

    }
    
}
