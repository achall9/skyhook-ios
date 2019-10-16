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

    enum Status {
              case PENDING
              case STARTED
              case COMPLETE
    }
    
    var id: String?
    var name: String?
    var totalElapsedMillis:Int = 0
    var flags:String = ""
    var notes:String = ""
//    var file = nil

    var time: Double = 0.00
    var timer = Timer()
    
    var file: GraphQLFile?
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    /// TEMP VARIABLES
    var beginLat = 0.0
    var beginLong = 0.0

    func loadActivity(_ info: NSDictionary) {
        self.id = info.value(forKey: "id") as? String
        self.name = info.value(forKey: "name") as? String
        self.totalElapsedMillis = info.value(forKey: "totalElapsedMillis") as? Int ?? 0
        self.flags = info.value(forKey: "flags") as? String ?? ""
        self.notes = info.value(forKey: "notes") as? String ?? ""
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.time = 0.00

    }
    
    
    //start time tracking
    func startTracking(){
        print("START")
        
        //Repeat checkin process...
           UserDefaults.standard.set("", forKey: "path")
           UserDefaults.standard.set(nil, forKey: "time_check")
           UserDefaults.standard.set(0.0, forKey: "lat_check")
           UserDefaults.standard.set(0.0, forKey: "lng_check")
        
           self.updateStart(activityId: self.id ?? "") { result in
           
               if result {
                // SUCCESS - started tracking
                self.appDelegate.activity = self
                self.appDelegate.isTracking = true
                 
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.UpdateTimer), userInfo: nil, repeats: true)
                
               } else {
                   // Failed...
                    
               }
           }


     
    }
    
    
    
    //stop time tracking
    func stopTracking(){
        
        self.updateStop(activityId: self.id ?? "") { result in
        
            if result {
             // SUCCESS - started tracking
                self.time = 0.00
                print("STOP")
                self.appDelegate.activity = nil
                self.appDelegate.isTracking = false
                self.timer.invalidate()
                 
                  
                //Repeat tracking checkin process...
                UserDefaults.standard.set("", forKey: "path")
                UserDefaults.standard.set(nil, forKey: "time_check")
                UserDefaults.standard.set(0.0, forKey: "lat_check")
                UserDefaults.standard.set(0.0, forKey: "lng_check")
             
            } else {
                // Failed...
                 
            }
        }
      
    }
    
    @objc func UpdateTimer() {
        time = time + timer.timeInterval
        
        NotificationCenter.default.post(name:
            Notification.Name(Notifications.UPDATE_TIMER), object: nil)
        
        /// *** Flag and Monitoring Logic *** ///
        
        //every 5 seconds push location coordinates to api to track user's route to destination -- display this on web portal
        
       // if i %% 5 {
       //send user share instance lat and long
  //  }
        
        //when receive location data Check for these:
        
        //      Driving Task
        //      - driving task on and stationary for > 4 minutes, flag it.
        //      - driving task on 10 minutes longer than estimated maps time, flag it
        //      - location is not relative to driving zone -- same state? , flag it
        
        //      Non-Driving Task
        //      - stationary task and movement > 0.25 miles, flag it,  send push 'Did you forget to //turn off your tracking?'
        //     - location is not relative to insured/claimant data, flag it
        //
        
        //      All Tasks
        // -- No internet, flag it, track locally until internet is available again
        

        
    //    Additional Notes --> We may want to add/edit/remove the activity 'name' from the admin panel down the road -- this could eventually be an ID if we go that route maybe?
      //  name = "Driving to Destination"
      //  total elapsed millis = 500000
        //  geo data (lat/lon/elapsed/flags) = {{lat:124.123,long:-12.313,elapsed:32000,flags ""}}
     //   notes = "Was some heavy traffic"
        
        //       //
        
    }
    


    func createNew (claimId:String, name:String, status: ActivityStatusInput, completion: @escaping (Activity?) -> ()) {
           
        
        let activityMutation = CreateActivityMutation(claimId:claimId, name:name, status: status)
        
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
    
    
    func updateStart(activityId: String, completion: @escaping (Bool) -> ()){
        
        let updateMutation = UpdateActivityStartMutation(activityId: activityId)
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

                              
            let resultMap = try! result.get().data?.resultMap
                              
            let resultDic = resultMap as NSDictionary?
                                     
                                
            if resultDic == nil { // FAILED
                                
                completion(false)
                                  
            } else { // SUCCESS
                                  
                completion(true)
                                  
            }
                              
        }
        
    }
    
        func updateStop(activityId: String, completion: @escaping (Bool) -> ()){
        
        let updateMutation = UpdateActivityEndMutation(activityId: activityId)
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

                              
            let resultMap = try! result.get().data?.resultMap
                              
            let resultDic = resultMap as NSDictionary?
                                     
            if resultDic == nil { // FAILED
                                
                completion(false)
                                  
            } else { // SUCCESS
                completion(true)
                                  
            }
                              
        }
        
    }
    
    func updateGeo(activityId: String, path: String, flag: String, completion: @escaping (Bool) -> ()) {
        
        let updateMutation = UpdateActivityGeoInputMutation(activityId: activityId, path: path, flag: flag)

        print(path)
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

            let resultMap = try! result.get().data?.resultMap
            let resultDic = resultMap as NSDictionary?
                                   
            if resultDic == nil { // FAILED
                    completion(false)
                } else { // SUCCESS
                    completion(true)
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

            let resultMap = try! result.get().data?.resultMap
            let resultDic = resultMap as NSDictionary?
                                   
            if resultDic == nil { // FAILED
                    completion(false)
                } else { // SUCCESS
                    completion(true)
                }
        }

    }
    
    
    func uploadFile(){
        
    }
 
   
    
}

