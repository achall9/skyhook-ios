//
//  Address.swift
//  Skyhook
//
//  Created by Alexander Hall on 10/6/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import Foundation

class Address: NSObject {
    
    var street1:String?
       var street2:String?
       var city:String?
       var state:String?
       var zip:String?
       
    
    func loadAddress(info:NSDictionary){
        self.street1 = info.value(forKey: "street1") as? String ?? ""
        self.street2 = info.value(forKey: "street2") as? String ?? ""
        self.city = info.value(forKey: "city") as? String ?? ""
        self.state = info.value(forKey: "state") as? String ?? ""
        self.zip = info.value(forKey: "zip") as? String ?? ""
    }
    
    func toString () -> String {
        return "\(self.street1 ?? "") \(self.street2 ?? ""), \(self.city ?? ""), \(self.state ?? "") \(self.zip ?? "")"
    }
    
}
