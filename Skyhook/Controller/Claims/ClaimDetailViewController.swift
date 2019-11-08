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
import MTSlideToOpen

class ClaimDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ClaimHeaderDelegate, ActivityItemDelegate, MTSlideToOpenDelegate {
   
    @IBOutlet weak var claimNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeClaimView: MTSlideToOpenView!
    
    @IBOutlet weak var addActivityButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.claimNumberLabel.text = self.claim?.claimNumber
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityItemTableViewCell")
    
        setHeader()
        
        handleClosedClaim()
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         tableView.reloadData()
     }
    
    
    func handleClosedClaim() {
        if self.claim?.status == .closed {
            closeClaimView.isHidden = true
            addActivityButton.alpha = 0.0
        }
        else {
            closeClaimView.defaultLabelText = "CLOSE CLAIM"
            closeClaimView.defaultSlidingColor = ColorUtils.getPurpleColor()
            closeClaimView.defaultThumbnailColor = ColorUtils.getPurpleColor()
            closeClaimView.delegate = self
        }
    }
    
    
    func setHeader(){
        
        let view = (Bundle.main.loadNibNamed("ClaimHeaderView", owner: self, options: nil)![0] as! ClaimHeaderView)
        view.delegate = self
        view.setViews(claim:claim!)

        //set headerview to tableview
        tableView.tableHeaderView = view
    
    }
    
    
    //claim header info button click -- Delegate function, Claim Table View Cell
       func didTapInfo() {
           let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimInfoViewController") as! ClaimInfoViewController
           viewController.claim = self.claim
           self.navigationController?.pushViewController(viewController, animated: true)
       }
       
       
       @IBAction func goBack(_ sender: Any) {
            self.appDelegate.enterApp(true)
       }
       
       
       @IBAction func addNewActivity(_ sender: Any) {
           let viewController = self.storyboard?.instantiateViewController(withIdentifier: "NewActivityViewController") as! NewActivityViewController
           viewController.claim = self.claim
           self.navigationController?.pushViewController(viewController, animated: true)
       }
    
    
    
    // MARK: MTSlideToOpenDelegate
    func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
        self.claim?.closeClaim(claimId: (self.claim?.id!)!) { result in
            //closed claim
            if result {
                  let alertController = UIAlertController(title: "Success!", message: "This claim has now been closed.", preferredStyle: .alert)
                        let doneAction = UIAlertAction(title: "Okay", style: .default) { (action) in
                            self.appDelegate.enterApp(true)
                        }
                        alertController.addAction(doneAction)
                        self.present(alertController, animated: true, completion: nil)
            } else {
                // Failed...
                self.showError(message:"Failed to close claim. Did you close out all your actvities?")
            }
        }
        
    }

    
    //started driving activity -- Delegate function, Activity Table View Cell
    func didStartActivity() {
        self.offerDirections()
    }
    
    func offerDirections(){
        let alert = UIAlertController(title: "Directions", message: "Would you like to open up a map directions to the destination?", preferredStyle: .alert)
               
               alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { [weak alert] (_) in
                
            
                       // go to maps address for navigation if needed
                       
                       let geocoder = CLGeocoder()
                if let locationString = self.claim?.claimant?.address?.toString() {
                    geocoder.geocodeAddressString(locationString) { (placemarks, error) in
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

        if appDelegate.isTracking && cell.activity?.id == appDelegate.activity?.id {
            cell.activity = appDelegate.activity
            cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
        }
        
        if cell.activity?.status == .started && !appDelegate.isTracking {
            cell.activity?.continueTracking()
            cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
        }
        else if cell.activity?.status == .complete {
            cell.playButton.alpha = 0.0
        }
        
        cell.nameLabel.text = claim?.activities[indexPath.row].name
        
        if cell.activity?.flags != nil && cell.activity?.flags != "" {
            setFlagIcon(label: cell.nameLabel, name: (claim?.activities[indexPath.row].name)!)
        }
           
        cell.setTime(time:(cell.activity?.totalElapsedMillis)!)
           
        
        return cell
    }
    
    
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if claim?.activities[indexPath.row].status != .complete {
            return true
        } else {
            return false
        }
    }

  func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .normal, title: "Finish") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            Activity().updateStop(activityId: (self.claim?.activities[indexPath.row].id)!) {
                result in
                //success
                if let cell = tableView.cellForRow(at: indexPath) as? ActivityItemTableViewCell {
                    cell.playButton.alpha = 0.0
                }
                
            }
        }
        editAction.backgroundColor = ColorUtils.getRedColor()

        return [editAction]
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
    
    func startError(){
        showError(message:"This activity has already been finished. Please add a new activity to begin tracking.")
    }
}
