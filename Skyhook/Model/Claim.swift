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
    var activities:[Activity] = []
    var status: ClaimStatus?
    var customer: User?
    var firm: User?
    var claimant: User?
    var insured: User?
    var dueDate: String?
    var lossDate: String?
    var notes: String?
    var uploads: [String] = []


    func loadClaim(node: NSDictionary) {
        
        self.id = node.value(forKey: "id") as? String ?? ""
        self.claimNumber = node.value(forKey: "claimNumber") as? String ?? ""
        self.status = node.value(forKey: "status") as? ClaimStatus
        self.notes = node.value(forKey: "notes") as? String ?? "No notes set."
        self.claimDate = formattedClaimDate(claimDate: node.value(forKey: "claimDate") as? String ?? "")
        self.dueDate = formattedClaimDate(claimDate: node.value(forKey: "dueDate") as? String ?? "")
        self.lossDate = formattedClaimDate(claimDate: node.value(forKey: "lossDate") as? String ?? "")

       // Claim Attachments
        let claimUploads = node.value(forKey: "uploads") as? [NSDictionary] ?? []
        for upload in claimUploads {
            uploads.append(upload.value(forKey: "url") as? String ?? "")
        }
            
        
        
        // Parse claim owner / customer
        let customer = User()
        let customerDic = node.value(forKey:"customer") as? NSDictionary
        if customerDic != nil {
            customer.loadCustomer(customer: customerDic!)
        }
        self.customer = customer
              
        //Parse IA firm that claim was assigned to
        let firm = User()
        let firmDic = node.value(forKey:"ia") as? NSDictionary
        if firmDic != nil {
            firm.loadFirm(firm: firmDic!)
        }
        self.firm = firm
        
        
        //activities parse
        var activities:[Activity] = []
        let actsDic = node.value(forKey: "activities") as? NSDictionary
        let actEdges = actsDic?.value(forKey: "edges") as? [NSDictionary]
        for actEdge in actEdges ?? [] {
            let actNode = actEdge.value(forKey: "node") as? NSDictionary
            let activity = Activity()
            activity.loadActivity(actNode!)
            if(activity.status != .complete) {
                activities.append(activity)
            }
        }
        self.activities = activities
            
                        
        //claimaint parse
        let claimantDic = node.value(forKey: "claimant") as? NSDictionary
        let claimant = User()
        claimant.loadClaimant(claimant: claimantDic!)
        self.claimant = claimant
        
        
        //insured parse
        let insuredDic = node.value(forKey: "insured") as? NSDictionary
        let insured = User()
        insured.loadInsured(insured: insuredDic!)
        self.insured = insured
                        
       
    }
    
    func formattedClaimDate(claimDate:String)->String {
        print(claimDate)
        if claimDate == "" {
            return ""
        }
        var date = claimDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        
        if let dateVal = dateFormatter.date(from:date) {
            dateFormatter.dateFormat = "MM/dd/yyyy"
            date = dateFormatter.string(from: dateVal)
            return date
        }
        else{
            return ""
        }
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
        self.dueDate = ""
        self.notes = ""
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
                
                if edges != nil {
                    for edge in edges! {
                        let node = edge.value(forKey: "node") as? NSDictionary

                        let claim = Claim()
                        if let dic = node {
                            claim.loadClaim(node: dic)
                            claims.append(claim)
                        }
                    }
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
