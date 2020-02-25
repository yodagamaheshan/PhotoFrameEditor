//
//  SplashViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/24/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit
import Firebase

class SplashViewController: UIViewController {
    
    static func create() -> SplashViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: SplashViewController.self)) as? SplashViewController
        return viewController!
    }


    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
            if Auth.auth().currentUser != nil {
              // User is signed in.
                self.goTo(viewController: HomeViewController.create())
            } else {
              // No user is signed in.
              self.goTo(viewController: RegisterViewController.create())
            }

        })
    }
    
    func moveToCorrectVC(){
        
    }
}
