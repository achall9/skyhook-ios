//
//  EnableNotificationsViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/26/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import UserNotifications

class EnableNotificationsViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func enableNotifications(_ sender: Any) {
        
        UNUserNotificationCenter.current() // 1
            .requestAuthorization(options: [.alert, .sound, .badge]) { // 2
                granted, error in
                print("Permission granted: \(granted)") // 3
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnableLocationViewController") as! EnableLocationViewController
                    self.navigationController?.pushViewController(secondViewController, animated: true)
                }
             
               
        }
        
        //
      
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
