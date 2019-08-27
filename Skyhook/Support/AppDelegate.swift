//
//  AppDelegate.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

//import Firebase
import UIKit
import Firebase
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var isTracking: Bool = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        
        //account exists
        let emailDefaults = UserDefaults.standard.string(forKey: "email")
        print("EMAIL Account Found! \(emailDefaults)")

        if emailDefaults != nil && emailDefaults != "" {
            enterApp(true)
        } else {
            enterApp(false)
        }
//
        return true
    }
    
    
    
    
    func enterApp(_ loggedIn: Bool) {
        var navigationController: UINavigationController?
        var storyboard: UIStoryboard?

        if loggedIn {  // authorized user -- directo to main tabs if location permissions set, else tkae to location enable controller
            
            if checkLocationPermissions(){
                storyboard = UIStoryboard(name: "Main", bundle: nil)
                navigationController = storyboard!.instantiateViewController(withIdentifier :"mainNavController") as? UINavigationController
                
            }
            else {
                storyboard = UIStoryboard(name: "Auth", bundle: nil)
                navigationController = storyboard!.instantiateViewController(withIdentifier :"authNavController") as? UINavigationController
                
                let locationViewController = storyboard?.instantiateViewController(withIdentifier: "EnableLocationViewController") as! EnableLocationViewController
                navigationController?.pushViewController(locationViewController, animated: false)
                
            }
         
            
        } else { // unauthorize user -- directo to sign in screen
            storyboard = UIStoryboard(name: "Auth", bundle: nil)
            
            navigationController = storyboard!.instantiateViewController(withIdentifier :"authNavController") as? UINavigationController

        }

        self.window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        UIView.transition(with: window!, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: { _ in })
    
    }
    
    
    func checkLocationPermissions()->Bool {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access to location")
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access to location enabled")
                return true
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

