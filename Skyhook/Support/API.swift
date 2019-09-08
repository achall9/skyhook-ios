//
//  API.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/13/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//
//import Firebase
import UIKit
import Firebase

class API: NSObject {
    class var sharedInstance: API {
        struct Static {
            static let instance: API = API()
        }
        return Static.instance
    }
    
    var headers = ["Content-Type": "application/json"]
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let rootR = Database.database().reference()
    
    func checkUserExists(email: String)->Bool {
        var exists = false
        rootR.child("FCM_TOKENS").queryOrderedByKey().observeSingleEvent(of: .value) { (snapchat) in
            let v = snapchat.value as! NSDictionary
            if v[email] != nil {
                exists = true
            }
        }
        
        return exists
    }
    
    func saveUserToken(uid:String, token: String){
        var val = [String:Any]()
        val[uid] = token
        rootR.child("FCM_TOKENS").setValue(val)
    }
}

//func getRegion(completion: @escaping (_ region: Industry?) -> Void) {
//    let header: HTTPHeaders = ["Content-type" : "application/json", "Authorization": Employee.sharedInstance.authorization!]
//    Alamofire.request(APIURL.getRegion, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: header).responseJSON { response in
//        if response.result.isSuccess {
//            let info = response.result.value as! NSDictionary
//            if info.value(forKey: "data") == nil {
//                completion(nil)
//            }else {
//                completion(Industry(info.value(forKey: "data") as! NSDictionary))
//            }
//        }else {
//            completion(nil)
//        }
//    }
//}




