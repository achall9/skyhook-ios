//
//  ClaimsViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/14/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit
import Apollo
import Crashlytics

class ClaimsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FilterClickDelegate  {
    
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var placeholderView: UIView!
    
    var claims: [Claim] = []
        
    var indicator: UIActivityIndicatorView!

    @IBOutlet weak var timerButton: UIButton!
    
    var filterView: ClaimFilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set tableview to view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ClaimsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClaimCell")
        
                      
        NotificationCenter.default.addObserver(
               self,
               selector: #selector(self.updateTime),
               name: NSNotification.Name(rawValue: Notifications.UPDATE_TIMER),
               object: nil)
        
        self.getClaims(filter:0)

         
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.appDelegate.isTracking {
            self.timerButton.alpha = 1.0

            self.timerButton.alignTextUnderImage()
            self.timerButton.setTitle(timeString(time: appDelegate.activity!.totalElapsedMillis), for: .normal)
        } else {
            self.timerButton.alpha = 0.0
            self.timerButton.alignToNormal()
            self.timerButton.setTitle("", for: .normal)
        }
        
    }
    
    @objc func updateTime(){
        if let activity = appDelegate.activity {
              self.timerButton.setTitle(timeString(time: appDelegate.activity!.totalElapsedMillis), for: .normal)
        }
      
    }
    
    func timeString(time:Int) -> String {
           let hours = Int(time) / 3600
           let minutes = Int(time) / 60 % 60
           let seconds = Int(time) % 60
           return String(format: "%02i:%02i" , minutes, seconds)
       }
       
    
    // get claims assigned to current user
    func getClaims(filter:Int){
       self.showLoading()

        Claim.sharedInstance.fetchClaims() { claims in
            self.claims.removeAll()
            self.stopLoading()
            
            switch filter {
            case 0:
                var sorted = claims
                sorted.sort(by: { $0.claimDate!.compare($1.claimDate!) == .orderedDescending})
                for claim in sorted {
                    if claim.status != .closed {
                        self.claims.append(claim)
                    }
                }

                break
            default:
                 var sorted = claims
                 sorted.sort(by: { $0.dueDate!.compare($1.dueDate!) == .orderedAscending})
                for claim in sorted {
                    if claim.status != .closed {
                        self.claims.append(claim)
                     }
                    }
                              break
            }
            
            if self.claims.count > 0 {
                self.placeholderView.alpha = 0.0
                self.tableView.reloadData()
            } else {
                self.placeholderView.alpha = 1.0

            }
        }
    }
    
    @IBAction func showFilterOptions(_ sender: Any) {
        // Set Company View for GBIC and IA Firm
        filterView = .fromNib()
        filterView.frame = CGRect(x: self.view.frame.width - filterView.frame.width-10 , y: 50, width: filterView.frame.width, height: filterView.frame.height)
        filterView.layer.cornerRadius = 3
        filterView.setBorders()
        filterView.delegate = self
        
        self.view.addSubview(filterView)

    }
    
    func didClickFilter(value:Int){
        if filterView != nil {
            filterView.removeFromSuperview()
        }
        self.getClaims(filter:value)
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
                
        cell.statusView.layer.borderWidth = 0.0
        cell.statusLabel.text = claims[indexPath.row].status?.rawValue
        cell.statusView.backgroundColor = ColorUtils.getOrangeColor()
        for act in claims[indexPath.row].activities {
            if act.status == .started {
                cell.statusView.layer.borderWidth = 2.0
                cell.statusView.layer.borderColor = ColorUtils.getGreenColor().cgColor
                cell.statusView.pulsate()
            }
        }
       
   
        cell.claimNumberLabel.text = claims[indexPath.row].claimNumber
        cell.claimantNameLabel.text = claims[indexPath.row].claimant?.fullName
        cell.insuredNameLabel.text = claims[indexPath.row].insured?.fullName
        
        cell.dateLabel.text = "Assigned: \(claims[indexPath.row].claimDate?.description ?? "")"
        
        
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
