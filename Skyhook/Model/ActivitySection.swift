//
//  ActivitySection.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/21/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ActivitySection: NSObject {
    // MARK: - Variables And Properties
    
    var id: String?
    var name: String?
    var activities: [Activity]?
    
    func loadActivitySection(_ info: NSDictionary) {
        //        self.id = info["id"] != nil ? info["id"] as? Int : self.id
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.activities = []
    }
    
}
