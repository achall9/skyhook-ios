//
//  BaseViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/2/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//


/// *** BASE VIEW CONTROLLER TO HOLD COMMON FUNCTIONS ACROSS APP CONTROLLERS *** //
// - Show Alert, Send push,


import UIKit

class BaseViewController: UIViewController {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var claim: Claim?
    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showError(){
        
        let alert = UIAlertController(title: "Error", message: "Failed to create new activity. Please try again later.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay",style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }

  
}
