//
//  Claim.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/19/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class Claim: NSObject {
    // MARK: - Variables And Properties
    
    var id: String?
    var name: String?
    var attachments:[String] = []
    var activities:[Activity] = []
    
    func loadClaim(_ info: NSDictionary) {
        //        self.id = info["id"] != nil ? info["id"] as? Int : self.id
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.attachments = []
    }
    
    func addActivity(activity: Activity){
        //add to api and here
        activities.append(activity)
    }
    
    func beginTracking(){
        //turn on time tracker
        //turn on location watching
        //turn on notification sender -- if app is force closed.
        //
        
    }
    
    func stopTracking(){
        //turn off all
    }

}
