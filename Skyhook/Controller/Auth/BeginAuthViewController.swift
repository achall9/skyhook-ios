//
//  BeginAuthViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

//**** PENDING APIS -- UserExists, Get Profile, Create Profile --- ****

import UIKit
import Firebase

class BeginAuthViewController: UIViewController, UITextFieldDelegate {
  
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var forgotPwBtn: UIButton!
    @IBOutlet weak var subHeaderLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    var email: String!
    var password: String!
   
    var phase: Int = 0
    // phase 0 = email input
    // phase 1 = new user register
    // phase 2 = login existing user
    
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //attributes for underlining forgot password button
    let yourAttributes : [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor : UIColor.black,
        NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        textField.delegate = self
        textField.becomeFirstResponder()
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1.0
        
        let attributeString = NSMutableAttributedString(string: "Forgot your password?",
                                                        attributes: yourAttributes)
        forgotPwBtn.setAttributedTitle(attributeString, for: .normal)
        forgotPwBtn.alpha = 0.0
        errorLbl.alpha = 0.0

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("KEYBOARD CLICK")
        self.continueButton.sendActions(for: .touchUpInside)
        return true
    }
    

    @IBAction func onContinue(_ sender: Any) {
        print("CONTINUE CLICK")
        switch(phase){
        case 0:
            if emailValidated(email: textField.text!) {
                segmentSwitch.selectedSegmentIndex = 1

                if userExists() {
                    self.phase = 2 //user exists, allow login
                    self.textField.text = ""
                    self.textField.placeholder = "Enter password"
                    self.textField.isSecureTextEntry = true
                    self.subHeaderLbl.text = "Enter your password to log back in"
                    textField.becomeFirstResponder()

                    
                }
                else {
                    self.phase = 1
                    self.textField.text = ""
                    self.textField.placeholder = "Create new password"
                    self.textField.isSecureTextEntry = true
                    self.subHeaderLbl.text = "Register a password"
                    textField.becomeFirstResponder()


                }
            }
            break
            
        case 1:
            //register new user and take to app
            if passwordValidated(password: textField.text!) {
               registerUser(email: self.email , password: self.password)
            }
            break
        case 2:
            //login user
            if passwordValidated(password: textField.text!){
                loginUser(email: self.email, password: self.password)
            }
            break
        default:
            break
            
        }
        
        
    }
    
    func userExists() -> Bool {
        
        return true
    }
    
    
    
    func emailValidated(email:String)->Bool{
        errorLbl.alpha = 0.0
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: email){
            self.email = email
            return true
        }
        
        errorLbl.alpha = 1.0
        errorLbl.text = "Please enter a valid email"
        
        return false
    }
    
    func passwordValidated(password:String)->Bool {
        errorLbl.alpha = 0.0
       
        if password.count > 5 {
            self.password = password
            return true
        }
        
        errorLbl.text = "Password must be 6 or more characters long"
        errorLbl.alpha = 1.0
        
        return false
        
    }
    
    
    // Login User //
    func loginUser(email: String, password: String){
        errorLbl.alpha = 0.0
        self.forgotPwBtn.alpha = 0.0
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            guard let strongSelf = self else { return }
            if error != nil {
                print(error)
                strongSelf.errorLbl.alpha = 1.0
                if (error?.localizedDescription.contains("There is no user record corresponding"))!{
                    strongSelf.errorLbl.text = "No user found with these credentials."
                    strongSelf.forgotPwBtn.alpha = 1.0
                }
              
                
            } else {
               //success
               //get profile, login to app
                
                //save login instance
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(password, forKey: "password")
                
                
                strongSelf.appDelegate.enterApp(true)

            }
        }
        
    }
    
    
    
    // Register New User //

    func registerUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            // ...
            if error != nil {
                print(error)
                self.errorLbl.alpha = 1.0
                if error.debugDescription.contains("The email address is already in use"){
                    self.errorLbl.text = "Account already exists with this email"
                }
            } else {
                var user = authResult?.user
                //set profile to API  and direct into app
                
                
                
                
                
                
                //save login instance
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(password, forKey: "password")

                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnableNotificationsViewController") as! EnableNotificationsViewController
                self.navigationController?.pushViewController(secondViewController, animated: true)
                

            }
        }
    }
    
   
    // Forgot Password //
    @IBAction func forgotPasswordClick(_ sender: Any) {
        showForgotPassword()
    }
    
    func showForgotPassword(){
        errorLbl.alpha = 0.0

        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email address to send a reset link.", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Enter email"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let email = alert?.textFields![0] // Force unwrapping because we know it exists.
            Auth.auth().sendPasswordReset(withEmail: email!.text!) { error in
                if error != nil {
                   //no email registered?
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    

    

}
