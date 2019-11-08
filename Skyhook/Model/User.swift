//
//  User.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import CoreLocation
import Apollo

class User: NSObject {
    class var sharedInstance: User {
        struct Static {
            static let instance: User = User()
        }
        return Static.instance
    }
    // MARK: - Variables And Properties
    
    var id: String?
    var fullName: String?
    var email: String?
    var roleId: String?
    var jwt: String?
    
    var business:String?
    var phone: String?
    var address: Address?
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

   
    func loadUser(_ id: String?, _ fullName: String?, _ email: String?, _ role: String?, _ jwt: String?) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.roleId = role
        self.jwt = jwt
    }
    
    func loadCustomer(customer:NSDictionary) {
        self.id = customer.value(forKey: "id") as? String
        self.business = customer.value(forKey: "customerName") as? String
        self.phone = customer.value(forKey: "phone") as? String
        self.fullName = customer.value(forKey: "customerContact") as? String
        
        if let addrDic = customer.value(forKey: "address") as? NSDictionary {
            let address = Address()
            address.loadAddress(info: addrDic)
            self.address = address
        }
    }
    
    func loadClaimant(claimant:NSDictionary){
        self.fullName = claimant.value(forKey: "name") as? String
        self.phone = claimant.value(forKey: "phone") as? String
        self.email = claimant.value(forKey: "email") as? String

        if let addrDic = claimant.value(forKey: "address") as? NSDictionary {
                let address = Address()
                address.loadAddress(info: addrDic)
                self.address = address
        }
    }
    
    func loadInsured(insured:NSDictionary) {
         self.fullName = insured.value(forKey: "name") as? String
         self.phone = insured.value(forKey: "phone") as? String
         self.email = insured.value(forKey: "email") as? String

         if let addrDic = insured.value(forKey: "address") as? NSDictionary {
                let address = Address()
                address.loadAddress(info: addrDic)
                self.address = address
         }
     }
    
    
    func initialize() {
        self.id = ""
        self.fullName = ""
        self.email = ""
        self.roleId = ""
        self.jwt = ""
    }
    
    func exists() -> Bool{
        //call api for check if user exists or not
        return false
        
    }
    
    func login (email:String, password:String, completion: @escaping (Bool) -> ()) {
        
        let loginMutation = LoginUserMutation(email: email, password: password)
        let apollo = ApolloClient(url: URL(string: GraphQL.ENDPOINT)!)
        
        apollo.perform(mutation: loginMutation) { (result) in
            
            let resultMap = try! result.get().data?.resultMap
            let resultDic = resultMap as NSDictionary?
            let loginDic = resultDic?.value(forKey: "login") as? NSDictionary
            
            if loginDic == nil { // failed
                completion(false)
                
            } else { // SUCCESS
                
                let userDic = loginDic?.value(forKey: "user") as? NSDictionary
                
                let fullName = userDic?.value(forKey: "fullName") as? String ?? ""
                let email = userDic?.value(forKey: "email") as? String ?? ""
                let id = userDic?.value(forKey: "id") as? String ?? ""
                let role = userDic?.value(forKey: "roleId") as? String ?? ""
                let jwt = userDic?.value(forKey: "jwt") as? String ?? ""
                self.loadUser(id, fullName, email, role, jwt)
                
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(password, forKey: "password")
                
                completion(true)
                
            }
        }
    }
    
    func logout(){
        self.initialize()
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "password")
    }
    
    func register (email:String,password:String){
        
    }
    
}
