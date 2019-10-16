//
//  ClaimDetailViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/18/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ClaimDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ClaimHeaderDelegate, SlideButtonDelegate, ActivityItemDelegate {
   
    @IBOutlet weak var claimNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeClaimButton: SlidingButton!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.claimNumberLabel.text = self.claim?.claimNumber
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityItemTableViewCell")
        
        closeClaimButton.delegate = self
        
        if self.claim?.status == ClaimStatus.closed {
            closeClaimButton.unlock()
        }
         
        setHeader()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
       
    }
    
    //Slide Button Delegate
    func buttonStatus(status: String, sender: SlidingButton) {
        print(status)
        
    }
    
    //started driving activity -- Delegate function, Activity Table View Cell
    func didStartActivity() {
        self.offerDirections()
    }
    
    func offerDirections(){
        let alert = UIAlertController(title: "Route to Destination", message: "Would you like to open up a map directions to the destination?", preferredStyle: .alert)
               
               alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak alert] (_) in
                
            
                       // go to maps address for navigation if needed
                       
                       let geocoder = CLGeocoder()
                if let locationString = self.claim?.customer?.address?.toString() {
                    geocoder.geocodeAddressString(locationString) { (placemarks, error) in
                    if let error = error {
                        print(error.localizedDescription)
                            } else {
                                if let location = placemarks?.first?.location {
                                    let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude)
                                    let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
                                 mapItem.name = self.claim?.claimant?.business ?? "Claimant"
                                    mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
                                    
                                }
                            }
                        }
                }
                       
                    
               }))
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               
               self.present(alert, animated: true, completion: nil)
    }
    
    
    //claim header info button click -- Delegate function, Claim Table View Cell
    func didTapInfo() {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimInfoViewController") as! ClaimInfoViewController
        //        viewController.claim = claims[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    func setHeader(){
        
        let view = (Bundle.main.loadNibNamed("ClaimHeaderView", owner: self, options: nil)![0] as! ClaimHeaderView)
        view.delegate = self
        view.setViews(claim:claim!)

        //set headerview to tableview
        tableView.tableHeaderView = view
    
    }
    
    
    @IBAction func goBack(_ sender: Any) {
      self.navigationController?.popViewController(animated: false)
    }
    
    
    @IBAction func addNewActivity(_ sender: Any) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewActivityViewController") as! NewActivityViewController
        viewController.claim = self.claim
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
     
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ActivityDetailViewController") as! ActivityDetailViewController
        viewController.selectedIndex = indexPath.row
        viewController.claim = self.claim
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (claim?.activities.count)!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityItemTableViewCell") as! ActivityItemTableViewCell
     
        cell.delegate = self
        cell.activity = claim?.activities[indexPath.row]
        cell.nameLabel.text = claim?.activities[indexPath.row].name
        if cell.activity?.flags != nil && cell.activity?.flags != "" {
            setFlagIcon(label: cell.nameLabel, name: (claim?.activities[indexPath.row].name)!)
        }
        
        if cell.activity?.id == appDelegate.activity?.id && appDelegate.isTracking {
            cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
        }
//        cell.timeLabel.text = String(claim?.activities[indexPath.row].totalElapsedMillis)
        //        if indexPath.row == 0 {
//            if appDelegate.activity != nil && (appDelegate.activity?.name?.contains("Driving"))! {
//                cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
//                cell.activity = appDelegate.activity
//                cell.nameLabel.text = appDelegate.activity!.name
//
//            } else {
//                let a = Activity()
//                a.name = "Driving to Destination"
//                cell.activity = a
//                cell.nameLabel.text = a.name
//
//            }
//
//
//        }
//        if indexPath.row == 1 {
//            if appDelegate.activity != nil && (appDelegate.activity?.name?.contains("Met"))! {
//                cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
//                cell.activity = appDelegate.activity
//                cell.nameLabel.text = appDelegate.activity!.name
//
//            } else {
//                let a = Activity()
//                a.name = "Met with Claimant"
//                cell.activity = a
//                cell.nameLabel.text = a.name
//            }
//        }
      
//        cell.activity = claim?.activities[indexPath.row]
        
        return cell
    }
    
    func setFlagIcon(label: UILabel, name: String){
        //Create Attachment
        let imageAttachment =  NSTextAttachment()
        imageAttachment.image = UIImage(named:"Status_orange")
        //Set bound to reposition
        let imageOffsetY:CGFloat = -5.0;
        imageAttachment.bounds = CGRect(x:0, y: imageOffsetY, width: 20, height: 20)
        //Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        //Initialize mutable string
        let completeText = NSMutableAttributedString(string: "")
        //Add image to mutable string
        //Add your text to mutable string
        let  textAfterIcon = NSMutableAttributedString(string: "  \(name)")

        completeText.append(attachmentString)
        completeText.append(textAfterIcon)

        label.attributedText = completeText;
    }
    
   
    

    func confirmWithAlert(){
        
        let alert = UIAlertController(title: "Confirm Action", message: "Are you sure you want to close this claim? You cannot undo this action.", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Close Claim",style: .default, handler: {(alert: UIAlertAction!) in
            
            //update claim to closed
            
            
        }))
        alert.addAction(UIAlertAction(title:"Cancel", style: .cancel))
        
        
        
        self.present(alert, animated: true, completion: nil)
    }
}
