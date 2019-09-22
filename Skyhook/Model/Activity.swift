//
//  Activity.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/21/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import CoreLocation

class Activity: NSObject {
    // MARK: - Variables And Properties
    
    var id: String?
    var name: String?
    var time: Double = 0.00
    var timer = Timer()
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    /// TEMP VARIABLES
    var beginLat = 0.0
    var beginLong = 0.0

    func loadActivity(_ info: NSDictionary) {
        //        self.id = info["id"] != nil ? info["id"] as? Int : self.id
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.time = 0.00

    }
    
    
    //start time tracking
    func startTracking(){
        appDelegate.activity = self
        appDelegate.isTracking = true
    
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
    }
    
    
    
    //stop time tracking
    func stopTracking(){
        self.time = 0.00
        print("STOPPED")
        appDelegate.activity = nil
        appDelegate.isTracking = false
        timer.invalidate()
    }
    
    @objc func UpdateTimer() {
        time = time + timer.timeInterval
        
        NotificationCenter.default.post(name: Notification.Name(Notifications.UPDATE_TIMER), object: nil)
        
        /// *** Flag and Monitoring Logic *** ///
        
        //every 5 seconds push location coordinates to api to track user's route to destination -- display this on web portal
        
       // if i %% 5 {
       //send user share instance lat and long
  //  }
        
        //when receive location data Check for these:
        
        //      Driving Task
        //      - driving task on and stationary for > 4 minutes, flag it.
        //      - driving task on 10 minutes longer than estimated maps time, flag it
        //      - location is not relative to driving zone -- same state? , flag it
        
        //      Non-Driving Task
        //      - stationary task and movement > 0.25 miles, flag it,  send push 'Did you forget to //turn off your tracking?'
        //     - location is not relative to insured/claimant data, flag it
        //
        
        //      All Tasks
        // -- No internet, flag it, track locally until internet is available again
        

        
    //    Additional Notes --> We may want to add/edit/remove the activity 'name' from the admin panel down the road -- this could eventually be an ID if we go that route maybe?
      //  name = "Driving to Destination"
      //  total elapsed millis = 500000
        //  geo data (lat/lon/elapsed/flags) = {{lat:124.123,long:-12.313,elapsed:32000,flags ""}}
     //   notes = "Was some heavy traffic"
        
        //       //
        
    }
 
    
}
