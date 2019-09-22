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
    // MARK: - Variables And Properties
    
    var id: String?
    var name: String?
    var claimNumber: String?
    var attachments:[String] = []
    var activities:[Activity] = []
    var status: String?

    
    func loadClaim(_ info: NSDictionary) {
        //        self.id = info["id"] != nil ? info["id"] as? Int : self.id
    }
    
    func initialize() {
        self.id = ""
        self.name = ""
        self.attachments = []
    }

    
    
    func fetchClaims (completion: @escaping ([Claim]) -> ()) {
        let apollo = ApolloClient(url: URL(string: GraphQL.ENDPOINT)!)
        
        //            let apollo: ApolloClient = {
        //                let token = ""
        //                let configuration = URLSessionConfiguration.default
        //
        //                // Add additional headers as needed
        //                configuration.httpAdditionalHeaders = ["Authorization": "Bearer \(token)"]
        //                let url = URL(string: GraphQL.ENDPOINT)!
        //
        //                return ApolloClient(networkTransport: HTTPNetworkTransport(url: url, configuration: configuration))
        //
        //            }()
        
        let userDetailsQuery = UserDetailsQuery()
        apollo.fetch(query: userDetailsQuery) { result in
            switch result {
            case .success(let graphQLResult):
                print("SUCESS FOUND")
                
                let resultMap = try! result.get().data?.resultMap
                let resultDic = resultMap as NSDictionary?
                
//                completion(claims)
                
            case .failure(let error):
                // deal with network errors here
                print("FAILED TO QUERY CLAIMS")
                //                subHeaderLbl.text = result.get().data.ma
                // self.subHeaderLbl.text = "Welcome, \(welcomeUserName())"
                
            }
        }
    }
    
    
    func addActivity(activity: Activity){
        //add to api and here
        activities.append(activity)
    }

}
