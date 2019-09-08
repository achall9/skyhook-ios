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
    
    var user: User?
    var locationManager: CLLocationManager?
    var isTracking: Bool = false
    

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
        print("EMAIL Account Found --> \(emailDefaults)")

        if emailDefaults != nil && emailDefaults != "" {
            enterApp(true)
        } else {
            enterApp(false)
        }
//
        return true
    }
    
    
    //enter app function
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
            print("Location services are not enabled")
            return false
        }
    }
    
    
    
    //location tracking
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("New location is \(location)")
            user?.lat = location.coordinate.latitude
            user?.lng = location.coordinate.longitude
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
        
        Messaging.messaging().apnsToken = deviceToken
        
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
        
        sendLocalNotification()
        // Send push notification if tracking that it has stopped!
        if self.isTracking {
            // save tracking time ended flag it,
           
            
        }
    }

    
    func sendLocalNotification(){
        let notificationCenter = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent() // Содержимое уведомления
        
        content.title = "Tracking Stopped"
        content.body = "Please open Skyhook again to track your activity without being flagged."
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
