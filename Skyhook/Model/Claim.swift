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


    func loadClaim(id: String, claimNumber: String, activities:[Activity],
                   status: ClaimStatus, customer: User, claimant: User, insured: User, claimDate: String) {
        self.id = id
        self.claimNumber = claimNumber
        self.status = status
        self.activities = activities
        self.customer = customer
        self.claimant = claimant
        self.insured = insured
        self.claimDate = claimDate
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
                    print("NEW EDGE")
                    print(node?.allKeys)
                    
                    //activities parse
                    var activities:[Activity] = []
                    let actsDic = node?.value(forKey: "activities") as? NSDictionary
                    let actEdges = actsDic?.value(forKey: "edges") as? [NSDictionary]
                    for actEdge in actEdges! {

                        let actNode = actEdge.value(forKey: "node") as? NSDictionary
                        let activity = Activity()
                        
                        activity.loadActivity(actNode!)
                        print(activity.id)
                        activities.append(activity)
                    }
                    
                    
                    //claimaint parse
                    var claimants:[User] = []
                    let claimantsDic = node?.value(forKey: "claimant") as? NSDictionary
                    let claimantEdges = claimantsDic?.value(forKey: "edges") as? [NSDictionary]
                    for claimEdge in claimantEdges! {
                        
                        let claimantNode = claimEdge.value(forKey: "node") as? NSDictionary
                        let claimant = User()
                                                                     
                        claimant.loadClaimant(claimant: claimantNode!)
                        claimants.append(claimant)
                    }
                    if claimants.count == 0 {
                        claimants.append(User())
                    }
                    
                    //insured parse
                    var insuredUsers:[User] = []
                    let insuredDic = node?.value(forKey: "insured") as? NSDictionary
                    let insuredEdges = insuredDic?.value(forKey: "edges") as? [NSDictionary]
                    for insuredEdge in insuredEdges! {
                        
                        let insuredNode = insuredEdge.value(forKey: "node") as? NSDictionary
                        let insured = User()
                                                                     
                        insured.loadInsured(insured: insuredNode!)
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
                    claim.loadClaim(id: node?.value(forKey: "id") as! String, claimNumber: node?.value(forKey: "claimNumber") as! String, activities: activities, status: node?.value(forKey: "status") as! ClaimStatus, customer: customer, claimant: claimants[0], insured: insuredUsers[0], claimDate: node?.value(forKey: "claimDate") as? String ?? "")
                    
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

}
