//
//  EnableLocationViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/26/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import CoreLocation

class EnableLocationViewController: UIViewController, CLLocationManagerDelegate{
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    var locationManager: CLLocationManager?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
    }
    
    @IBAction func enableLocation(_ sender: Any) {
        //request access
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("AUTH STATUS CHANGE")
        if status == .authorizedAlways {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                //success
                self.appDelegate.enterApp(true)
            }
          
            
        } else {
            //denied authorization --- force alert
            
            let alert = UIAlertController(title: "Permission Required", message: "You must enable location permissions in your settings.", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Okay",style: .default, handler: {(alert: UIAlertAction!) in
                //open settings
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
                }
            }))
            
        
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    

}
