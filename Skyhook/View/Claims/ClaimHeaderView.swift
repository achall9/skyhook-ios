//
//  ClaimHeaderView.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/19/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ClaimHeaderView: UIView {
    @IBOutlet weak var firmLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactAddressLabel: UILabel!
    
    var claim: Claim?
    
    func setViews(claim:Claim){
        self.claim = claim
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        //go to details view
    }
    
    @IBAction func clickAttachment(_ sender: Any) {
        //go to claim file view
    }
    
}
