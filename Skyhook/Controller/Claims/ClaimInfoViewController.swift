//
//  ClaimInfoViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/3/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ClaimInfoViewController: UIViewController, ContactViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    var claim: Claim?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
            // Set Company View for GBIC and IA Firm
            let compView: CompanyInfoView = .fromNib()
            compView.frame = CGRect(x: 15 , y: 10, width: self.scrollView.frame.width-30, height: compView.frame.height)
            compView.layer.cornerRadius = 3
            compView.layer.borderWidth = 1.0
            compView.layer.borderColor = UIColor.lightGray.cgColor
        
            if let claimInfo = claim {
                  compView.setViews(info: claimInfo)
            }
        
            containerView.addSubview(compView)
        
        
        
            // Set Contact View for Claimant and Insured
            let contactView: ContactInfoView = .fromNib()
            contactView.frame = CGRect(x: 15 , y: compView.frame.height + 20, width: self.scrollView.frame.width-30, height: contactView.frame.height)
            contactView.layer.cornerRadius = 3
            contactView.layer.borderWidth = 1.0
            contactView.layer.borderColor = UIColor.lightGray.cgColor
        
            if let claimInfo = claim {
                contactView.setViews(info: claimInfo)
            }
        
            contactView.delegate = self
        
            containerView.addSubview(contactView)
    }
    
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
 
    
    func didClickAddress(addr: String) {
         let alert = UIAlertController(title: "Route to Destination", message: "Would you like to open a map with directions to the destination?", preferredStyle: .alert)
                      
                      alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak alert] (_) in
                       
                   
                              // go to maps address for navigation if needed
                              
                              let geocoder = CLGeocoder()
                       if addr != "" {
                           geocoder.geocodeAddressString(addr) { (placemarks, error) in
                           if let error = error {
                               print(error.localizedDescription)
                                   } else {
                                       if let location = placemarks?.first?.location {
                                           let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
                                           let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                                        mapItem.name = self.claim?.claimant?.fullName ?? "Claimant"
                                           mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                                           
                                       }
                                   }
                               }
                       }
                              
                           
                      }))
                      alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
                      
                      self.present(alert, animated: true, completion: nil)
    }
    
    func didClickEmail(email: String) {
        if let url = URL(string: "mailto:\(email)"), UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    func didClickPhone(phone: String) {
           if let url = URL(string: "tel://\(phone)"), UIApplication.shared.canOpenURL(url) {
                 if #available(iOS 10, *) {
                     UIApplication.shared.open(url)
                 } else {
                     UIApplication.shared.openURL(url)
                 }
             }
    }

}
