//
//  ClaimsViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/14/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import Apollo

class ClaimsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView: UITableView!
    
    var claims: [Claim] = []
        
    var indicator: UIActivityIndicatorView!

    @IBOutlet weak var timerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set tableview to view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ClaimsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClaimCell")
        
        self.getClaims()
                
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(self.updateTime),
               name: NSNotification.Name(rawValue: Notifications.UPDATE_TIMER),
               object: nil)

         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.appDelegate.isTracking {
            self.timerButton.alpha = 1.0

            self.timerButton.alignTextUnderImage()
            self.timerButton.setTitle(timeString(time: appDelegate.activity!.time), for: .normal)
        } else {
            self.timerButton.alpha = 0.0
            self.timerButton.alignToNormal()
            self.timerButton.setTitle("", for: .normal)
        }
    }
    
    @objc func updateTime(){
        self.timerButton.setTitle(timeString(time: appDelegate.activity!.time), for: .normal)
    }
    
    func timeString(time:TimeInterval) -> String {
           let hours = Int(time) / 3600
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format: "%02i:%02i" , minutes, seconds)
       }
       
    
    // get claims assigned to current user
    func getClaims(){
       self.showLoading()
   
        Claim.sharedInstance.fetchClaims() { claims in
            self.stopLoading()
            self.claims = claims
            self.tableView.reloadData()
        }
    }
    
    @IBAction func showFilterOptions(_ sender: Any) {

    }
    
    @IBAction func clickedTimerButton(_ sender: Any) {
        //go to currently timed activity
    }
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimDetailViewController") as! ClaimDetailViewController

        viewController.claim = claims[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.layer.masksToBounds = true
        
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return claims.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell") as! ClaimsTableViewCell
                
        switch(claims[indexPath.row].status) {
        case .open:
            cell.statusLabel.text = "OPEN"
            cell.statusView.backgroundColor = ColorUtils.getRedColor()
            break
        case .active:
                cell.statusLabel.text = "ACTIVE"
            cell.statusView.backgroundColor = ColorUtils.getOrangeColor()
            break
        default:
            cell.statusLabel.text = "CLOSED"
            cell.statusView.backgroundColor = ColorUtils.getGreenColor()
            break
        }
        
        cell.claimNumberLabel.text = claims[indexPath.row].claimNumber
        cell.claimantNameLabel.text = claims[indexPath.row].claimant?.fullName
        cell.insuredNameLabel.text = claims[indexPath.row].insured?.fullName

        cell.dateLabel.text = claims[indexPath.row].claimDate?.description
        
        return cell
    }
    
    
    func showLoading() {
          indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
          indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
          indicator.center = self.view.center
          self.view.addSubview(indicator)
          self.view.bringSubviewToFront(indicator)
          UIApplication.shared.isNetworkActivityIndicatorVisible = true
          indicator.startAnimating()
      }
      
      func stopLoading(){
          indicator.stopAnimating()
      }

}
