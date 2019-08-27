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
        print("STOP")
        timer.invalidate()
    }
    
    @objc func UpdateTimer() {
        print(time)
        time = time + timer.timeInterval
        NotificationCenter.default.post(name: Notification.Name(Notifications.UPDATE_TIMER), object: nil)
        
        //every 5-15 seconds push location coordinates to api after running a check
        //        if counter == %5 {
        //
        //        }
        
    }
    
    
}
