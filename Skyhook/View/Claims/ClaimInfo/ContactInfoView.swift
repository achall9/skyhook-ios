//
//  ContactInfoView.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/4/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

protocol ContactViewDelegate {
    func didClickAddress(addr:String)
    func didClickPhone(phone:String)
    func didClickEmail(email:String)
}

class ContactInfoView: UIView {
    
    // Insured Fields
    @IBOutlet weak var insuredNameLabel: UILabel!
    
    @IBOutlet weak var insuredPhoneLabel: UIButton!
    
    @IBOutlet weak var insuredEmailLabel: UIButton!
    
    @IBOutlet weak var insuredAddressLabel: UIButton!
    
    
    // Claimant Fields
    @IBOutlet weak var claimantNameLabel: UILabel!
    
    @IBOutlet weak var claimantPhoneLabel: UIButton!
    
    @IBOutlet weak var claimantEmailLabel: UIButton!
    
    @IBOutlet weak var claimantAddressLabel: UIButton!
    
    var delegate: ContactViewDelegate?

    
    // Set the data
    func setViews(info: Claim) {
        // Set Insured Data
        
        if let name = info.insured?.fullName {
            insuredNameLabel.text = name
        }
        if let phone = info.insured?.phone {
            insuredPhoneLabel.setTitle(phone, for: .normal)
        }
        if let email = info.insured?.email {
            insuredEmailLabel.setTitle(email, for: .normal)
        }
        if let address = info.insured?.address {
            insuredAddressLabel.setTitle(address.toString(), for: .normal)
        }
        
        
        // Set Claimant Data
        if let name = info.claimant?.fullName {
            claimantNameLabel.text = name
        }
        if let phone = info.claimant?.phone {
            claimantPhoneLabel.setTitle(phone, for: .normal)
        }
        if let email = info.claimant?.email {
            claimantEmailLabel.setTitle(email, for: .normal)
        }
        if let address = info.claimant?.address {
            claimantAddressLabel.setTitle(address.toString(), for: .normal)
        }
              
    }
    
    @IBAction func insuredPhoneClick(_ sender: Any) {
        delegate?.didClickPhone(phone: insuredPhoneLabel.titleLabel?.text ?? "")
    }
    
    @IBAction func insuredEmailClick(_ sender: Any) {
        delegate?.didClickEmail(email: insuredEmailLabel.titleLabel?.text ?? "")
    }
    
    @IBAction func insuredAddressClick(_ sender: Any) {
        delegate?.didClickAddress(addr: insuredAddressLabel.titleLabel?.text ?? "")
    }
    
    @IBAction func claimantPhoneClick(_ sender: Any) {
        delegate?.didClickPhone(phone: claimantPhoneLabel.titleLabel?.text ?? "")
    }
    @IBAction func claimantEmailClick(_ sender: Any) {
        delegate?.didClickEmail(email: claimantEmailLabel.titleLabel?.text ?? "")
    }
    
    @IBAction func claimantAddressClick(_ sender: Any) {
        delegate?.didClickAddress(addr: claimantAddressLabel.titleLabel?.text ?? "")
    }
    
    
}
