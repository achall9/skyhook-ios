//
//  User.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class User: NSObject {
    class var sharedInstance: User {
        struct Static {
            static let instance: User = User()
        }
        return Static.instance
    }
    // MARK: - Variables And Properties
    
    var id: String?
    var name: String?
    var email: String?
    var lat: Double?
    var lng: Double?

    func loadUser(_ info: NSDictionary) {
//        self.id = info["id"] != nil ? info["id"] as? Int : self.id
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.email = ""
        self.lat = 0.0
        self.lng = 0.0
    }
    
    func exists() -> Bool{
        //call api for check if user exists or not
        return false
        
    }
    
    func login (email:String,password:String){
        
        UserDefaults.standard.setValue(email, forKey: "email")
        UserDefaults.standard.setValue(password, forKey: "password")
    }
    
    
    func logout(){
        self.initialize()
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "password")
    }
    
    func register (email:String,password:String){
        
    }
    
}
