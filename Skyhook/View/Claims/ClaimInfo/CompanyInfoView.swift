//
//  CompanyInfoView.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/4/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class CompanyInfoView: UIView {

    @IBOutlet weak var gbicLabel: UILabel!
    @IBOutlet weak var gbicContactLabel: UILabel!
    @IBOutlet weak var gbicPhoneLabel: UILabel!
    
    
    @IBOutlet weak var iaLabel: UILabel!
    @IBOutlet weak var iaContactLabel: UILabel!
    @IBOutlet weak var iaPhoneLabel: UILabel!
    
    
    func setViews(info: Claim){
        
        //   Set DBIC Data
        if let gbic = info.customer?.business {
            gbicLabel.text = gbic
        }
        if let name = info.customer?.fullName {
            gbicContactLabel.text = name
        }
        if let phone = info.customer?.phone {
            gbicPhoneLabel.text = phone
        }
        
    }
    
    

}
