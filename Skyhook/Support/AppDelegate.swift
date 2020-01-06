//
//  AppDelegate.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import Firebase
import UIKit
import CoreLocation
import UserNotifications
import FirebaseMessaging

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    
    var user: User?
    var locationManager: CLLocationManager?
    var isTracking: Bool = false
    var activity: Activity?
    var currentLocation: CLLocation?
    var pathArr : [Any] = []
    
    let gcmMessageIDKey = "gcm.message_id"
    
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
 
        // [START register_for_notifications]
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        //account exists so login
        let emailDefaults = UserDefaults.standard.string(forKey: "email")
        let passwordDefaults = UserDefaults.standard.string(forKey: "password")
        if emailDefaults != nil && emailDefaults != "" {
            User.sharedInstance.login(email: emailDefaults!, password: passwordDefaults ?? "") { result in
                if result { //success
                    self.clearCache()
                } else {
                 self.enterApp(false)
                }
            }
        } else {
            enterApp(false)
        }

        
        return true
    }
    
    
    //enter app function
    func enterApp(_ loggedIn: Bool) {
        var navigationController: UINavigationController?
        var storyboard: UIStoryboard?

        if loggedIn {  // authorized user -- directo to main tabs if notification and location permissions set, else tkae to location enable controller
            if checkNotificationPermissions() {
                
                if checkLocationPermissions(){
                    
                    self.configureLocationSettings()

                    storyboard = UIStoryboard(name: "Main", bundle: nil)
                    navigationController = storyboard!.instantiateViewController(withIdentifier :"mainNavController") as? UINavigationController
                    
                }
                else {
                    
                    storyboard = UIStoryboard(name: "Auth", bundle: nil)
                    navigationController = storyboard!.instantiateViewController(withIdentifier :"authNavController") as? UINavigationController
                    
                    let locationViewController = storyboard?.instantiateViewController(withIdentifier: "EnableLocationViewController") as! EnableLocationViewController
                    navigationController?.pushViewController(locationViewController, animated: false)
                    
                }
            } else {
                
                storyboard = UIStoryboard(name: "Auth", bundle: nil)
                navigationController = storyboard!.instantiateViewController(withIdentifier :"authNavController") as? UINavigationController
                
                let locationViewController = storyboard?.instantiateViewController(withIdentifier: "EnableNotificationsViewController") as! EnableNotificationsViewController
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
    
    
    //check notifications are enabled
    func checkNotificationPermissions()->Bool {
        // [START register_for_notifications]
        let notificationType = UIApplication.shared.currentUserNotificationSettings!.types
        if notificationType == [] {
            print("notifications are NOT enabled")
            return false
        } else {
            print("notifications are enabled")
            return true
        }
    }

    
    //check location is enabled
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
            print("Location services are NOT enabled")
            return false
        }
    }
    
    
    func configureLocationSettings() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager!.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.desiredAccuracy = kCLDistanceFilterNone
    }
    
    
    
    //location tracking
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let location = locations.last {
//            print("****** New location is \(location) *******")
            self.currentLocation = location
            
            if self.isTracking {
                print("Location updated")
                print(location.timestamp)

                // register latest path
                pathArr = [self.currentLocation?.coordinate.latitude ?? 0.0, self.currentLocation?.coordinate.longitude ?? 0.0, location.timestamp.millisecondsSince1970] as [Any]
                           
                var path = UserDefaults.standard.string(forKey: "path")
                if path == nil || path == "" {
                    path = "\(pathArr.description)"
                } else {
                    path = "\(path!), \(pathArr.description)"
                }
                           
                UserDefaults.standard.set(path, forKey: "path")
                
                //check for cases that could cheat the system
                timeCheckin(location: location, path: path ?? "")
            }
            
        }
        
    }
    
    func timeCheckin(location:CLLocation, path:String) {
        if UserDefaults.standard.object(forKey: "time_check") != nil {
        
            let startTime = (UserDefaults.standard.object(forKey: "time_check") as? Date)!
            let diffInMinutes = Calendar.current.dateComponents([.minute], from: startTime, to: location.timestamp).minute
          
            print(startTime)
            print(location.timestamp)
            //4 minutes passed, validate driving and stationary task
            if diffInMinutes! >= 4 {
                print("TIMES UP --> Validate Activity now")
                validateUserActivity(path:path)
            }
            
        } else {
            UserDefaults.standard.set(location.timestamp, forKey: "time_check")
            UserDefaults.standard.set(location.coordinate.latitude, forKey: "lat_check")
            UserDefaults.standard.set(location.coordinate.longitude, forKey: "lng_check")

        }
    }
    
    
    func validateUserActivity(path:String) {
                
        if UserDefaults.standard.float(forKey: "lat_check") != nil {
            let startLat = UserDefaults.standard.object(forKey: "lat_check") as! CLLocationDegrees
            let startLng = UserDefaults.standard.object(forKey: "lng_check") as! CLLocationDegrees
            
            let start = CLLocation(latitude: startLat, longitude: startLng)
          
            let distanceInMeters = start.distance(from: self.currentLocation!)
            print("DISTANCE TRAVELED: \(distanceInMeters)")
            
            
            var flag = ""
            print("DRIVE TASK CONFIRM")
            if distanceInMeters < 30 {
                // under 100 feet (30 meters) and driving task
                if (activity?.name?.contains("Driv"))! {
                    flag = "NO MOVEMENT DRIVING"
                    self.sendLocalNotification(title:"Driving Activity Flagged",message: "Your location has not moved significantly in over 4 minutes time.")
                }
            }
            else if distanceInMeters >= 30 {
                // out of 100 foot radius and not driving task.. not good
                if !(activity?.name?.contains("Driv"))! {
                    flag = "UNAPPROVED MOVEMENT"
                    self.sendLocalNotification(title:"Stationary Activity Flagged",message: "Did you forget to turn off your tracking?")
                }
            }
                
            
            self.activity!.updateGeo(activityId: activity?.id ?? "", path: path, flag: flag) { result in
                
                if result {
         
                    //Repeat checkin process...
                    UserDefaults.standard.set(self.pathArr.description, forKey: "path")
                    UserDefaults.standard.set(nil, forKey: "time_check")
                    UserDefaults.standard.set(0.0, forKey: "lat_check")
                    UserDefaults.standard.set(0.0, forKey: "lng_check")

                } else {
                    // Failed...
                   // DO NOT RESET THE SAVED DATA.
                }
            }
            
        }
    }
    
    
    func clearCache(){
        UserDefaults.standard.synchronize()
        if let id: String = UserDefaults.standard.value(forKey: "actId") as? String {
            if id != "" {
                print("ACTIVITY ID FOUND-- Pausing with flag")
                Activity().stopTracking(id: id, flag: "FORCE CLOSED APP") {
                    result in
                    
                    self.enterApp(true)
                    
                }
            } else {
                self.enterApp(true)
            }
            

        } else {
            self.enterApp(true)
        }
        
    }

    

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // Print message ID.
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        UIApplication.shared.applicationIconBadgeNumber = UIApplication.shared.applicationIconBadgeNumber + 1
        
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
        
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
    // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
    // the InstanceID token.
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNs token retrieved: \(deviceToken)")
        
        //Messaging.messaging().apnsToken = deviceToken
    }

    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("BEGIN BACK")
          if self.isTracking {
              print(UserDefaults.standard.value(forKey: "actId"))

          } else {
              UserDefaults.standard.set("", forKey: "actId")

          }
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        UIApplication.shared.applicationIconBadgeNumber = 0

    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        
        // Send push notification if tracking that it has stopped!
        if self.isTracking {
                // save tracking time ended flag it,
                self.sendLocalNotification(title:"Tracking Paused", message: "Please open Skyhook again to track your activity.")
          

        }
       
    }
    
   

    
    func sendLocalNotification(title:String, message:String){
        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = title
        content.body = message
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: nil)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
    

}




// [START ios_10_message_handling]
@available(iOS 10.0, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        print(userInfo["action"] as Any)
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        completionHandler([.alert,.sound,.badge])


        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
//        self.userInfo = userInfo
//        self.makingRoot("enterApp")
//
        completionHandler()
    }
    
    // AK : Notifiction foreground
    func userNotificationCenter(_ center:UNUserNotificationCenter,
                                willPresent response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }
}



// [END ios_10_message_handling]
//
extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        UserDefaults.standard.set(fcmToken, forKey: "fcmToken")

    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Received data message: \(remoteMessage.appData)")
        
        _ = remoteMessage.appData
        
    }
    // [END ios_10_data_message]
}

 

