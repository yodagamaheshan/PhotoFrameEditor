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
           backgroundView.styleWithRoundCorner(with: UIColor.white, filling:  UIColor.getAppColor(color: .creem) ?? UIColor.white )
        }
        loginButton.styleForRoundCorners()
        loginButton.backgroundColor = UIColor.getAppColor(color: .lightYellow)
    }
    
    @IBAction func login(_ sender: Any) {
        
        if isValidate(email: emailTF.text, and: passwordTF.text){
            Auth.auth().signIn(withEmail: emailTF.text!, password: passwordTF.text!) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                if authResult == nil{
                    //email pw wrong
                    self?.showAllert(and: "Login not successfull")
                }
                else{
                    //email verified
                    if let user = Auth.auth().currentUser, user.isEmailVerified{
                        self?.goTo(viewController: HomeViewController.create())
                    }else{
                        self?.sendVarificationEmail()
                    }
                }
            }
        }
        
    }
    
    func isValidate(email: String?, and password: String?) -> Bool{
        let email = email?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if email?.isEmpty ?? true {
            showAllert(and: "Enter the correct Email")
            return false
        } else if password?.isEmpty ?? true {
            showAllert(and: "Enter the correct password")
            return false
        }
         return true
    }
    
    func sendVarificationEmail(){
           if let user = Auth.auth().currentUser, let userEmail = user.email{
                   let alertVC = UIAlertController(title: "Error", message: "Sorry. Your email address has not yet been verified. Do you want us to send another verification email to \(userEmail).", preferredStyle: .alert)
                   let alertActionOkay = UIAlertAction(title: "Okay", style: .default) {
                       (_) in
                       user.sendEmailVerification(completion: nil)
                   }
                   let alertActionCancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                   
                   alertVC.addAction(alertActionOkay)
                   alertVC.addAction(alertActionCancel)
                   self.present(alertVC, animated: true, completion: nil)
               }
           }
    
    @IBAction func notRegisteredPressed(_ sender: Any) {
        self.goTo(viewController: RegisterViewController.create())
    }
    
    @IBAction func fogetPWPressed(_ sender: Any) {
        goTo(viewController: FogotPassWordViewController.create())
    }
    
}
