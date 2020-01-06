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
    
    var business: String?
    var phone: String?
    var address: Address?
    
    var legalBusiness: String?
    var legalContact: String?
    var legalPhone: String?
    var legalAddress: Address?
    
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
        self.business = customer.value(forKey: "name") as? String
        self.phone = customer.value(forKey: "phone") as? String
        self.fullName = customer.value(forKey: "contact") as? String
        
        if let addrDic = customer.value(forKey: "address") as? NSDictionary {
            let address = Address()
            address.loadAddress(info: addrDic)
            self.address = address
        }
    }
    
    func loadFirm(firm:NSDictionary) {
           self.id = firm.value(forKey: "id") as? String
           self.business = firm.value(forKey: "name") as? String
           self.phone = firm.value(forKey: "phone") as? String
           self.fullName = firm.value(forKey: "contact") as? String
           if let addrDic = firm.value(forKey: "address") as? NSDictionary {
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
        
        if let legalDic = claimant.value(forKey: "legal") as? NSDictionary {
            self.legalBusiness = legalDic.value(forKey: "name") as? String
            self.legalContact = legalDic.value(forKey: "contact") as? String
            self.legalPhone = legalDic.value(forKey: "phone") as? String
            if let addrDic = claimant.value(forKey: "address") as? NSDictionary {
                        let address = Address()
                        address.loadAddress(info: addrDic)
                        self.legalAddress = address
                }
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
        //firebase push notification token
        let token : String = UserDefaults.standard.string(forKey: "fcmToken") ?? ""
        
        let loginMutation = LoginUserMutation(email: email, password: password, registrationToken: token)
        let apollo = ApolloClient(url: URL(string: GraphQL.ENDPOINT)!)
        
        apollo.perform(mutation: loginMutation) { (result) in
            
            let resultMap = try! result.get().data?.resultMap
            let resultDic = resultMap as NSDictionary?
            let loginDic = resultDic?.value(forKey: "login") as? NSDictionary
            
            print(loginDic)

            if loginDic == nil { // failed
                completion(false)
                
            } else { // SUCCESS
        
                let userDic = loginDic?.value(forKey: "user") as? NSDictionary
                
                if (userDic?.value(forKey: "roleId") as? UserRole) == UserRole.fieldAdjuster {
                                   
                    let fullName = userDic?.value(forKey: "fullName") as? String ?? ""
                    let email = userDic?.value(forKey: "email") as? String ?? ""
                    let id = userDic?.value(forKey: "id") as? String ?? ""
                    let role = userDic?.value(forKey: "roleId") as? String ?? ""
                    let jwt = userDic?.value(forKey: "jwt") as? String ?? ""
                    self.loadUser(id, fullName, email, role, jwt)
                                   
                    UserDefaults.standard.setValue(email, forKey: "email")
                    UserDefaults.standard.setValue(password, forKey: "password")
                                   
                    completion(true)
                    
                } else {
  
                    completion(false)
                }
               
            }
        }
    }
    
    func logout(){
        self.initialize()
        UserDefaults.standard.setValue("", forKey: "email")
        UserDefaults.standard.setValue("", forKey: "password")
    }
    
    
    //password reset email
    func resetPassword (email:String, completion: @escaping (Bool) -> ()) {
          
//          let mutation = CreatePasswordResetRequestMutation(email: email)
//          let apollo = ApolloClient(url: URL(string: GraphQL.ENDPOINT)!)
//          
//          apollo.perform(mutation: mutation) { (result) in
//              
//            let resultMap = try! result.get().data?.resultMap
//            let resultDic = resultMap as NSDictionary?
//        
//            completion(true)
//              
//          }
      }
    
    
    func saveImage(image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else {
            return false
        }
        guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
            return false
        }
        do {
            try data.write(to: directory.appendingPathComponent("skyhook-profile.png")!)
            return true
        } catch {
            print(error.localizedDescription)
            
            return false
        }
    }
    
    func getSavedImage() -> UIImage? {
        if let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) {
            return UIImage(contentsOfFile: URL(fileURLWithPath: dir.absoluteString).appendingPathComponent("skyhook-profile.png").path)
        }
        return nil
    }
    
}
