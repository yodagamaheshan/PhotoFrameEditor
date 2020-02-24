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
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet var textFieldBackGrounds: [UIView]!
    @IBOutlet weak var loginButton: UIButton!
    
    static func create() -> LoginViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: LoginViewController.self)) as? LoginViewController
        return viewController!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView(){
        for backgroundView in textFieldBackGrounds{
           backgroundView.styleWithRoundCorner(with: UIColor.getAppColor(color: .creem) ?? UIColor.white, filling: UIColor.white)
        }
        loginButton.styleForRoundCorners()
    }
    
    @IBAction func login(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            debugPrint(authResult)
        }
        
    }
    
}
