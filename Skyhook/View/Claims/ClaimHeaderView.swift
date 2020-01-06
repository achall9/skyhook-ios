//
//  ClaimHeaderView.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/19/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol ClaimHeaderDelegate {
    func didTapInfo()
}

class ClaimHeaderView: UIView {
    @IBOutlet weak var firmLabel: UILabel!
    @IBOutlet weak var contactNameLabel: UILabel!
  
    @IBOutlet weak var contactPhoneButton: UIButton!
   
    @IBOutlet weak var contactAddressButton: UIButton!
    
    @IBOutlet weak var attachmentButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    var claim: Claim?
    
    var delegate: ClaimHeaderDelegate?

    
    func setViews(claim:Claim){
        self.claim = claim
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        self.firmLabel.text = claim.customer?.business ?? ""
        self.contactNameLabel.text = claim.claimant?.fullName ?? ""
        self.contactPhoneButton.setTitle(claim.claimant?.phone, for: .normal)
        self.contactAddressButton.setTitle(claim.claimant?.address?.toString(), for: .normal)
        self.dueDateLabel.text = "Due Date: \(claim.dueDate ?? "-")"
        
        
        //set attachments
        var attachments = "-"
        for url in claim.uploads {
            if attachments == "-" {
                attachments = "\(url)"
            } else {
                attachments = "\(attachments), \(url)"
            }
        }
        self.attachmentButton.setTitle(attachments, for: .normal)
        
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        //go to details view
        delegate?.didTapInfo()
        
    }
    
    @IBAction func clickAttachment(_ sender: Any) {
        
        if (claim?.uploads.count)! > 0 {
            //  go to file view on web url
            guard let url = URL(string: (claim?.uploads[0])!) else {
                  return //be safe
              }

              if #available(iOS 10.0, *) {
                  UIApplication.shared.open(url, options: [:], completionHandler: nil)
              } else {
                  UIApplication.shared.openURL(url)
              }
        }
        
    }
    
    @IBAction func clickAddress(_ sender: Any) {
        // go to maps address for navigation if needed
        
        let geocoder = CLGeocoder()
        let locationString = contactAddressButton.titleLabel?.text
        
        geocoder.geocodeAddressString(locationString!) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let location = placemarks?.first?.location {
                    let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                    mapItem.name = "Claimant"
                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                    
                }
            }
        }
        
    }
    
   
    @IBAction func callPhone(_ sender: Any) {
        // alert to call phone number
        if let url = URL(string: "tel://\(contactPhoneButton.titleLabel?.text ?? "")"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
 
    
}
