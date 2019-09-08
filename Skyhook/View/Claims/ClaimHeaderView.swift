//
//  ClaimHeaderView.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/19/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

protocol ClaimHeaderDelegate {
    func didTapInfo()
}

class ClaimHeaderView: UIView {
    @IBOutlet weak var firmLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneLabel: UILabel!
    @IBOutlet weak var contactAddressLabel: UILabel!
    
    var claim: Claim?
    
    var delegate: ClaimHeaderDelegate?

    
    func setViews(claim:Claim){
        self.claim = claim
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        let addrTap = UITapGestureRecognizer(target: self, action: #selector(self.handleAddrTap(_:)))
        contactAddressLabel.addGestureRecognizer(addrTap)
        
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(self.handlePhoneTap(_:)))
        contactAddressLabel.addGestureRecognizer(phoneTap)
        
                
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        //go to details view
        delegate?.didTapInfo()
        
    }
    
    @IBAction func clickAttachment(_ sender: Any) {
        //go to file view on web url
//        guard let url = URL(string: "http://www.google.com") else {
//            return //be safe
//        }
//
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
        
    }
    
    @objc func handleAddrTap(_ sender: UITapGestureRecognizer? = nil) {
        // go to maps address for navigation if needed
        UIApplication.shared.openURL(URL(string: "http://maps.apple.com/?address=\(contactAddressLabel.text ?? "")")!)
    }
    
    @objc func handlePhoneTap(_ sender: UITapGestureRecognizer? = nil) {
        // alert to call phone number
        if let url = URL(string: "tel://\(contactPhoneLabel.text ?? "")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
      
    }
    
}
