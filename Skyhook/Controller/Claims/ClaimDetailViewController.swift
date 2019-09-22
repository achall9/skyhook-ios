//
//  ClaimDetailViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/18/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ClaimDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ClaimHeaderDelegate, SlideButtonDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    
    var claim: Claim?
    
    @IBOutlet weak var closeClaimButton: SlidingButton!
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityItemTableViewCell")
        
        closeClaimButton.delegate = self
       
        setHeader()
        
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    //Slide Button Delegate
    func buttonStatus(status: String, sender: SlidingButton) {
        print(status)
    }
    
    
    //claim header info button click -- Delegate function
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
        //        viewController.claim = claims[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
     
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ActivityDetailViewController") as! ActivityDetailViewController
        viewController.activity = (tableView.cellForRow(at: indexPath) as! ActivityItemTableViewCell).activity
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityItemTableViewCell") as! ActivityItemTableViewCell
     
        if indexPath.row == 0 {
            if appDelegate.activity != nil && (appDelegate.activity?.name?.contains("Driving"))! {
                cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
                cell.activity = appDelegate.activity
                cell.nameLabel.text = appDelegate.activity!.name

            } else {
                let a = Activity()
                a.name = "Driving to Destination"
                cell.activity = a
                cell.nameLabel.text = a.name

            }
         

        }
        if indexPath.row == 1 {
            if appDelegate.activity != nil && (appDelegate.activity?.name?.contains("Met"))! {
                cell.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
                cell.activity = appDelegate.activity
                cell.nameLabel.text = appDelegate.activity!.name
                
            } else {
                let a = Activity()
                a.name = "Met with Claimant"
                cell.activity = a
                cell.nameLabel.text = a.name
            }
        }
      
//        cell.activity = claim?.activities[indexPath.row]
        
        return cell
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
