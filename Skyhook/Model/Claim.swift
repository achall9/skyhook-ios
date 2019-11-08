//
//  Claim.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/19/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import Apollo

class Claim: NSObject {
    
    class var sharedInstance: Claim {
           struct Static {
               static let instance: Claim = Claim()
           }
           return Static.instance
       }
       // MARK: - Variables And Properties
    // MARK: - Variables And Properties
    
 
    var id: String?
    var claimNumber: String?
    var claimDate: String?
//    var attachments:[String] = []
    var activities:[Activity] = []
    var status: ClaimStatus?
    var customer: User?
    var claimant: User?
    var insured: User?
    var dueDate: String?


    func loadClaim(id: String, claimNumber: String, activities:[Activity],
                   status: ClaimStatus, customer: User, claimant: User, insured: User, claimDate: String, dueDate: String) {
        self.id = id
        self.claimNumber = claimNumber
        self.status = status
        self.activities = activities
        self.customer = customer
        self.claimant = claimant
        self.insured = insured
        self.claimDate = formattedClaimDate(claimDate: claimDate)
        self.dueDate = formattedClaimDate(claimDate: dueDate)
    }
    
    func formattedClaimDate(claimDate:String)->String {
        var date = claimDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let dateVal = dateFormatter.date(from:date)!

        dateFormatter.dateFormat = "MM/dd/yyyy"
        date = dateFormatter.string(from: dateVal)

        return date
    }
    
    
    
    func initialize() {
        self.id = nil
//        self.attachments = []
        self.claimNumber = ""
        self.claimDate = ""
        self.activities = []
        self.status = nil
        self.customer = nil
        self.insured = nil
        self.claimant = nil
    }

    
    
    func fetchClaims (completion: @escaping ([Claim]) -> ()) {
        //let apollo = ApolloClient(url: URL(string: GraphQL.ENDPOINT)!)
        
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
        
        let claimsQuery = ClaimsListQuery()
        apollo.fetch(query: claimsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                var claims:[Claim] = []

                let resultMap = try! result.get().data?.resultMap
                let resultDic = resultMap as NSDictionary?
                let claimsDic = resultDic?.value(forKey: "claims") as? NSDictionary
                let edges = claimsDic?.value(forKey: "edges") as? [NSDictionary]
                
                for edge in edges! {
                    let node = edge.value(forKey: "node") as? NSDictionary
                    
                    //activities parse
                    var activities:[Activity] = []
                    let actsDic = node?.value(forKey: "activities") as? NSDictionary
                    let actEdges = actsDic?.value(forKey: "edges") as? [NSDictionary]
                    for actEdge in actEdges ?? [] {

                        let actNode = actEdge.value(forKey: "node") as? NSDictionary
                        let activity = Activity()
                        activity.loadActivity(actNode!)
                        activities.append(activity)
                    }
                    
                    
                    //claimaint parse
                    var claimants:[User] = []
                    let claimantsDic = node?.value(forKey: "claimant") as? [NSDictionary]
                    
                    for claimantDic in claimantsDic! {
                        let claimant = User()

                        claimant.loadClaimant(claimant: claimantDic)
                        claimants.append(claimant)
                    }
                
                    
                    if claimants.count == 0 {
                        claimants.append(User())
                    }
                    
                    
                    //insured parse
                    var insuredUsers:[User] = []
                    let insuredsDic = node?.value(forKey: "insured") as? [NSDictionary]
                  
                    for insuredDic in insuredsDic! {
                        let insured = User()
                        
                        insured.loadInsured(insured: insuredDic)
                        insuredUsers.append(insured)
                    }
                    if insuredUsers.count == 0 {
                        insuredUsers.append(User())
                    }
                    
                    
                    // get claim owner / customer
                    let customer = User()
                    let customerDic = node?.value(forKey:"customer") as? NSDictionary
                    customer.loadCustomer(customer: customerDic!)
                    
                    
            
                    let claim = Claim()
                    claim.loadClaim(id: node?.value(forKey: "id") as! String, claimNumber: node?.value(forKey: "claimNumber") as! String, activities: activities, status: node?.value(forKey: "status") as! ClaimStatus, customer: customer, claimant: claimants[0], insured: insuredUsers[0], claimDate: node?.value(forKey: "claimDate") as? String ?? "", dueDate: node?.value(forKey: "dueDate") as? String ?? "")
                    claims.append(claim)
                }
                    
                completion(claims)
                
            case .failure(let error):
                // deal with network errors here
                print("FAILED TO QUERY CLAIMS")
                
                completion([])
            }
        }
    }
    
    
    func addActivity(activity: Activity) {
        //add to api and here
        activities.append(activity)
    }
    
    
    func closeClaim(claimId: String, completion: @escaping (Bool) -> ()){
           
           let updateMutation = UpdateClaimEndMutation(claimId: claimId)
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
                       let res = resultDic!["updateClaimEnd"] as? NSDictionary
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

}
