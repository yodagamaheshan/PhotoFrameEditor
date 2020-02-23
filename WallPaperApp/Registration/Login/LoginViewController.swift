//
//  LoginViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
         debugPrint(authResult) 
        }
        
    }
    
}
