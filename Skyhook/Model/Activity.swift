//
//  Activity.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/21/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class Activity: NSObject {
    // MARK: - Variables And Properties
    
    var id: String?
    var name: String?
    var time: Double = 0.00
    var timer = Timer()
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

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
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
    }
    
    
    //stop time tracking
    func stopTracking(){
        print("STOPPED")
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
        // -- alert user tracking has ended if force close app with push notification
        
        
        // -- How do we determine when a claim is fully finished ? So cannot be opened up again and tracked.
      //  -- Add closed claim button in red
        
        
        //       //
        
    }
    
    
}
