//
//  RegisterViewController.swift
//  WallPaperApp
//
//  Created by Heshan Yodagama on 2/23/20.
//  Copyright © 2020 Heshan Yodagama. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet var textFieldContainers: [UIView]!
    @IBOutlet weak var sugnupButton: UIButton!
    
    static func create() -> RegisterViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: RegisterViewController.self)) as? RegisterViewController
        return viewController!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        for backgroundView in textFieldContainers{
            backgroundView.styleWithRoundCorner(with: UIColor.white , filling:  UIColor.getAppColor(color: .creem) ?? UIColor.white)
        }
        sugnupButton.styleForRoundCorners()
        sugnupButton.backgroundColor = UIColor.getAppColor(color: .lightYellow)
    }
    
    @IBAction func signupButtonPressed(_ sender: Any) {
        let name = firstNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isValied(name: name, email: email, and: password){
            let firebaseAuth = Auth.auth()
            firebaseAuth.createUser(withEmail: email!, password: password!) { authResult, error in
                if authResult == nil{
                    self.showAllert(and: "User Already Created or Check your internet")
                }else{
                    firebaseAuth.currentUser?.sendEmailVerification(completion: nil)
                    do {
                        try firebaseAuth.signOut()
                    } catch let signOutError as NSError {
                        print ("Error signing out: %@", signOutError)
                    }
                    
                    self.goToLogin(LoginViewController.create())
                }
            }
        } 
    }
    
    func isValied(name: String?,email: String?,and password: String?) -> Bool{
        if name?.isEmpty ?? true{
            self.showAllert(and: "Enter Name")
            return false
        }else if email?.isEmpty ?? true{
            self.showAllert(and: "Enter Email")
            return false
        }else if password?.isEmpty ?? true{
            self.showAllert(and: "Enter Password")
            return false
        }else if (password?.count ?? 0 < 6){
            self.showAllert(and: "Passwor must be greater then 6 digit")
            return false
        }
        return true
    }
    
   
    
    @IBAction func goToLogin(_ sender: Any) {
        self.goTo(viewController: LoginViewController.create())
    }
}
