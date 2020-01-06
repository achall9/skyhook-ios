//
//  Activity.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/21/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import CoreLocation
import Apollo

class Activity: NSObject {
    // MARK: - Variables And Properties
    
    let  IMAGE_VIEW_URL = "http://skyhook-accountability.s3.us-east-2.amazonaws.com/"

    var id:String?
    var name:String?
    var totalElapsedMillis:Int = 0
    var flags:String = ""
    var notes:String = ""
    var uploads:[String] = []
    var status:ActivityStatus?
        
    /// TEMP VARIABLES
    var beginLat = 0.02
    var beginLong = 0.0
    
    var timer: Timer?
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    func loadActivity(_ info: NSDictionary) {
        self.id = info.value(forKey: "id") as? String
        self.name = info.value(forKey: "name") as? String
        self.totalElapsedMillis = (info.value(forKey: "totalElapsedMillis") as? Int ?? 0)/1000 //convert to seconds
        self.flags = info.value(forKey: "flags") as? String ?? ""
        if let notesArr = info.value(forKey: "notes") as? [NSDictionary]{
            for note in notesArr {
                self.notes += "\(note.value(forKey: "note") as? String ?? "")\n"
            }
        }
        self.status = info.value(forKey: "status") as? ActivityStatus
        let uploadIdArr = info.value(forKey: "uploads") as? [NSDictionary]
        if uploadIdArr != nil {
            for upload in uploadIdArr! {
                self.uploads.append((upload["url"] as? String)!)
            }
        }
      
        
    }
    
    
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.totalElapsedMillis = 0
        self.flags = ""
        self.notes = ""
    }
    
    
    @objc func UpdateTimer() {
        totalElapsedMillis = totalElapsedMillis + Int(timer!.timeInterval)
          
          NotificationCenter.default.post(name:
              Notification.Name(Notifications.UPDATE_TIMER), object: nil)
          
      }
      
    
    
    func createNew (claimId:String, name:String, completion: @escaping (Activity?) -> ()) {
          var type:ActivityType = .onsite
          if name.contains("Driv") {
              type = .travel
          }
          let activityMutation = CreateActivityMutation(claimId:claimId, name:name, status: .pending, type: type)
          
             let apollo: ApolloClient = {
                        let token = User.sharedInstance.jwt
                        let configuration = URLSessionConfiguration.default

                        // Add additional headers as needed
                        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token ?? "")"]
                        let url = URL(string: GraphQL.ENDPOINT)!

                        //return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
                        let session = URLSession(configuration: configuration)
                        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session, sendOperationIdentifiers: false, useGETForQueries: false, delegate: nil))
                    }()
          
             apollo.perform(mutation: activityMutation) { (result) in
                 
                 let resultMap = try! result.get().data?.resultMap
                 let resultDic = resultMap as NSDictionary?

              if resultDic == nil { // FAILED
                     completion(nil)
                     
                 } else { // SUCCESS
                  
                     let createDic = resultDic?.value(forKey: "createActivity") as? NSDictionary
                  
                     let resultActivity = createDic?.value(forKey: "activity") as? NSDictionary

                     let activity = Activity()
                     activity.loadActivity(resultActivity!)
                  
                     completion(activity)
                  
                 }
             }
         }
      
      

    //start time tracking
    func startTracking(completion: @escaping (Bool) -> ()) {
        //Repeat checkin process...
        UserDefaults.standard.set("", forKey: "path")
        UserDefaults.standard.set(nil, forKey: "time_check")
        UserDefaults.standard.set(0.0, forKey: "lat_check")
        UserDefaults.standard.set(0.0, forKey: "lng_check")
        UserDefaults.standard.set(self.id, forKey: "actId")
        UserDefaults.standard.synchronize()

        /// NEW START
        self.grapqlStart(activityId: self.id ?? "") { result in
                     
            if result {
                print("STARTED")
                        
                // SUCCESS - started tracking
                self.appDelegate.activity = self
                self.appDelegate.isTracking = true
                           
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
                          
                completion(true)
                
            }
            else {
                // Failed...
                completion(false)
                  
            }
        }
     
    }
    
    
    //stop time tracking
    func stopTracking(id: String, flag: String, completion: @escaping (Bool) -> ()) {
        
        let path = UserDefaults.standard.string(forKey: "path")
        print(path)
        
        
        self.updateGeo(activityId: id, path: path ?? "", flag: flag) { result in
                                   
            if result {
                //updated geo now can stop activity
                print("STOPPING")
                self.grapqlStop(activityId: id) { result in
                                                                                        
                    if result {
                        self.status = .complete
                                                
                        // SUCCESS - stopped tracking
                        self.appDelegate.activity = nil
                        self.appDelegate.isTracking = false
                              
                        if let timer = self.timer {
                            timer.invalidate()
                        }
                                           
                        //cache management
                        UserDefaults.standard.set("", forKey: "actId")
                        
                        //Repeat checkin process...
                        UserDefaults.standard.set("", forKey: "path")
                        UserDefaults.standard.set(nil, forKey: "time_check")
                        UserDefaults.standard.set(0.0, forKey: "lat_check")
                        UserDefaults.standard.set(0.0, forKey: "lng_check")
                        
                        completion(true)
                                                                                     
                    } else {
                        // Failed...
                        completion(false)

                    }
                                  
                }
                               
                    
            } else {
                                 
                // Failed...
                               
                completion(false)
                // DO NOT RESET THE SAVED DATA.
                                     
            }
                                 
        }
                        
    }
    
    
    
    func grapqlStart(activityId: String, completion: @escaping (Bool) -> ()){
        
        let updateMutation = UpdateActivityStartMutation(activityId: activityId)
        let apollo: ApolloClient = {
                                            
            let token = User.sharedInstance.jwt
                                       
            let configuration = URLSessionConfiguration.default

            // Add additional headers as needed
            configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token ?? "")"]
                                      
            let url = URL(string: GraphQL.ENDPOINT)!
                      
            let session = URLSession(configuration: configuration)
                                        
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session, sendOperationIdentifiers: false, useGETForQueries: false, delegate: nil))
                                 
        }()

        apollo.perform(mutation: updateMutation) { (result) in
            print(result)
            let resultMap = try! result.get().data?.resultMap
            let resultDic = resultMap as NSDictionary?
            
            switch result {
                case .success(let graphQLResult):
                    print(graphQLResult)
                    let res = resultDic!["updateActivityStart"] as? NSDictionary
                    let success = res!["success"] as? Bool
                    if success! {
                        completion(true)

                    } else {
                        completion(false)
                    }
                case .failure(let error):
                    print("error: \(error)")
                    completion(false)

            }
                              
        }
        
    }

      
    
    func grapqlStop(activityId: String, completion: @escaping (Bool) -> ()){
        
        let updateMutation = UpdateActivityEndMutation(activityId: activityId)
        let apollo: ApolloClient = {
                                            
            let token = User.sharedInstance.jwt
                                       
            let configuration = URLSessionConfiguration.default

            // Add additional headers as needed
            configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token ?? "")"]
                                      
            let url = URL(string: GraphQL.ENDPOINT)!
            let session = URLSession(configuration: configuration)
                                        
            return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session, sendOperationIdentifiers: false, useGETForQueries: false, delegate: nil))
                                 
        }()

                              
        apollo.perform(mutation: updateMutation) { (result) in
            let resultMap = try! result.get().data?.resultMap
            let resultDic = resultMap as NSDictionary?
                                
            switch result {
                   
            case .success(let graphQLResult):
                        
                print(graphQLResult)
                let res = resultDic!["updateActivityEnd"] as? NSDictionary
                let success = res!["success"] as? Bool
                            
                if success! {
                    completion(true)
                } else {
                    completion(false)
                }
                     
            case .failure(let error):
                print("error: \(error)")
                completion(false)
            }
        }
        
    }
    
    func updateGeo(activityId: String, path: String, flag: String, completion: @escaping (Bool) -> ()) {
        
        let updateMutation = UpdateActivityGeoInputMutation(activityId: activityId, path: path, flag: flag)

        let apollo: ApolloClient = {
        let token = User.sharedInstance.jwt
        
        let configuration = URLSessionConfiguration.default

        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token ?? "")"]
        let url = URL(string: GraphQL.ENDPOINT)!

        //return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
       let session = URLSession(configuration: configuration)
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session, sendOperationIdentifiers: false, useGETForQueries: false, delegate: nil))
        }()

        apollo.perform(mutation: updateMutation) { (result) in
            
            switch result {
                case .success(let graphQLResult):
                    print(graphQLResult)
                    completion(true)
                case .failure(let error):
                    print("error: \(error)")
                    completion(false)

            }
         
        }

    }
    
    func updateNotes(activityId: String, notes: String, completion: @escaping (Bool) -> ()) {
        
        let updateMutation = UpdateNotesMutation(activityId: activityId, note:notes)

        let apollo: ApolloClient = {
        let token = User.sharedInstance.jwt
        
        let configuration = URLSessionConfiguration.default

        // Add additional headers as needed
        configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token ?? "")"]
        let url = URL(string: GraphQL.ENDPOINT)!

        //return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
       let session = URLSession(configuration: configuration)
        return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session, sendOperationIdentifiers: false, useGETForQueries: false, delegate: nil))
        }()

        apollo.perform(mutation: updateMutation) { (result) in
                                   
            switch result {
                    case .success(let graphQLResult):
                        print(graphQLResult)
                         if graphQLResult.errors != nil && graphQLResult.errors!.count > 0 {
                            completion(false)
                         } else {
                            completion(true)
                        }
                    case .failure(let error):
                        print("error: \(error)")
                        completion(false)
            }
            
        }

    }
    
    
     func uploadFile(activityId: String, file: String, completion: @escaping (Bool) -> ()){
            
            let updateMutation = ActivityFileUploadMutation(activityId: activityId, file: file)
            
             let apollo: ApolloClient = {
             let token = User.sharedInstance.jwt
             
             let configuration = URLSessionConfiguration.default

             // Add additional headers as needed
             configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token ?? "")"]
             let url = URL(string: GraphQL.ENDPOINT)!

             //return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
            let session = URLSession(configuration: configuration)
             return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, session: session, sendOperationIdentifiers: false, useGETForQueries: false, delegate: nil))
                 }()
           
            let image = UIImage(contentsOfFile: file)
            let data = image?.jpegData(compressionQuality: 0.9)
            let imageData: Data = data!
            let files = GraphQLFile(fieldName: "file", originalName: "fa_activity_upload.png", mimeType: "image/png", data: imageData)
            
            // Actually upload the file
        
        apollo.upload(operation: updateMutation,
                               files: [files]) { result in
                let resultMap = try! result.get().data?.resultMap
                let resultDic = resultMap as NSDictionary?

                                print(resultDic)
                if resultDic == nil { // FAILED
                    completion(false)
                                                    
                } else { // SUCCESS
                    
                    if resultDic?.value(forKey: "updateActivityUpload") != nil {
                        
                       completion(true)

                    } else {
                        completion(false)
                    }
                                                 
                }
        }
                            
        
    }
    
    
}

