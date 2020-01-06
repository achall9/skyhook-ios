//
//  BeginAuthViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

//**** PENDING APIS -- UserExists, Get Profile, Create Profile --- ****

import UIKit
//import Firebase
import Apollo

class BeginAuthViewController: UIViewController, UITextFieldDelegate {
  
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var forgotPwBtn: UIButton!
    @IBOutlet weak var subHeaderLbl: UILabel!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var segmentSwitch: UISegmentedControl!
    
    var indicator: UIActivityIndicatorView!
    
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
        
        // Must remove at the product version.
        //self.appDelegate.enterApp(true)
        
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
                self.phase = 1 //user exists, allow login
                self.textField.text = ""
                self.textField.placeholder = "Enter your password"
                self.textField.isSecureTextEntry = true
//                welcomeUserName() //set name in label welcoming back the user
                self.subHeaderLbl.text = "Enter your password to log back in"
                textField.becomeFirstResponder()
            }
            
            break
            
        case 1:
            //login user
            if passwordValidated(password: textField.text!){
                loginUser(email: self.email, password: self.password)
            }
            break
        default:
            break
            
        }
        
        
    }

 
    func emailValidated(email:String)->Bool {
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
    func loginUser(email: String, password: String) {
        errorLbl.alpha = 0.0
        self.forgotPwBtn.alpha = 0.0

        showLoading()
        
        User.sharedInstance.login(email: email.trimmingCharacters(in: .whitespaces), password: password.trimmingCharacters(in: .whitespaces)) { result in
            self.stopLoading()

            if result { //success
                self.appDelegate.enterApp(true)
                
            } else {
             
                //END DEV mode
                self.errorLbl.text = "Login not recognized"
                self.errorLbl.alpha = 1.0
                self.forgotPwBtn.alpha = 1.0
                
            }
            
        }
        
      
    }
    
    
    
  
   
    // Forgot Password //
    @IBAction func forgotPasswordClick(_ sender: Any) {
        showForgotPassword()
    }
    
    func showForgotPassword() {
     
        errorLbl.alpha = 0.0

        let alert = UIAlertController(title: "Forgot Password", message: "Enter your email address to send a reset link.", preferredStyle: .alert)
             
        alert.addTextField { (textField) in
            textField.placeholder = "Enter email"
            if self.email != nil {
                textField.text = self.email
            }
        }
             
        alert.addAction(UIAlertAction(title: "Reset", style: .default, handler: { [weak alert] (_) in
            let email = alert?.textFields![0].text! // Force unwrapping because we know it exists.
                
            if self.emailValidated(email: email!) {
                User().resetPassword(email: email! ) { result in
                    
                }
                
            }
                 
        }))
            
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
             
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    
    
    
    func showLoading() {
        indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = self.textField.center
        self.textField.addSubview(indicator)
        self.textField.bringSubviewToFront(indicator)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        indicator.startAnimating()
    }
    
    func stopLoading(){
        indicator.stopAnimating()
    }

    

}
