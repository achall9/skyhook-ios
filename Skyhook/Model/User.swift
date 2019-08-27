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

    func loadUser(_ info: NSDictionary) {
//        self.id = info["id"] != nil ? info["id"] as? Int : self.id
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.email = ""
    }
    
    func exists() -> Bool{
        //call api for check if user exists or not
        return false
        
    }
    
    func login (email:String,password:String){
        
    }
    
    func register (email:String,password:String){
        
    }
    
}
