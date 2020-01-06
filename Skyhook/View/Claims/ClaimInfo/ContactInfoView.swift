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
    
    
    // Claimant Legal Fields
    @IBOutlet weak var legalBusinessLabel: UILabel!
    
    @IBOutlet weak var legalContactNameLabel: UIButton!
    
    @IBOutlet weak var legalPhoneLabel: UIButton!
    
    @IBOutlet weak var legalAddressLabel: UIButton!
    
    
    // General Claim Fields
    @IBOutlet weak var notesLabel: UILabel!
    
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
        
        
        // Set Claimant Legal Data
        if let lBusiness = info.claimant?.legalBusiness {
            legalBusinessLabel.text = lBusiness
        }
        if let lContact = info.claimant?.legalContact {
            legalContactNameLabel.setTitle(lContact, for: .normal)
        }
        if let lPhone = info.claimant?.legalPhone {
            legalPhoneLabel.setTitle(lPhone, for: .normal)
        }
        if let lAddress = info.claimant?.legalAddress {
            legalAddressLabel.setTitle(lAddress.toString(), for: .normal)
        }
        
    
        // Set General Claim Data -- Notes, attachments, etc
        if info.notes != "" {
            notesLabel.text = info.notes
        } else {
            notesLabel.text = "No notes set."
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
    
    
    @IBAction func legalPhoneClick(_ sender: Any) {
          delegate?.didClickPhone(phone: legalPhoneLabel.titleLabel?.text ?? "")
    }
    
    @IBAction func legalAddressClick(_ sender: Any) {
         delegate?.didClickAddress(addr: legalAddressLabel.titleLabel?.text ?? "")
    }
    
}
