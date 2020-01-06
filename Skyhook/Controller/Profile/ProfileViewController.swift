//
//  ProfileViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/14/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var headerView : ProfileHeaderView!
    
    var claims: [Claim] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ClaimsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClaimCell")
       
      
        self.getClaims()
        
        //set profile headerview to table
        setHeader()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    
    func getClaims() {
        
        Claim.sharedInstance.fetchClaims() { claims in
            
            self.loadHeaderData(claims:claims)
            self.claims.removeAll()
            for claim in claims {
                if claim.status == .closed  {
                    self.claims.append(claim)
                }
            }
           
            self.tableView.reloadData()
                
        }
    }
    
    func setHeader(){
        
        headerView = (Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)![0] as! ProfileHeaderView)
        
        //profile image circular
        headerView.profileImage.layer.masksToBounds = false
        headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.height/2
        headerView.profileImage.clipsToBounds = true
        
        
        if let image = User().getSavedImage() {
            headerView.profileImage.image = image
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.profilePictureTap(_:)))
        headerView.profileImage.isUserInteractionEnabled = true
        headerView.profileImage.addGestureRecognizer(tap)
        
        // grid views
        headerView.view0.layer.masksToBounds = false
        headerView.view0.layer.cornerRadius = headerView.view0.frame.height/2
        headerView.view0.clipsToBounds = true
        
        headerView.view1.layer.masksToBounds = false
        headerView.view1.layer.cornerRadius = headerView.view1.frame.height/2
        headerView.view1.clipsToBounds = true
        
        headerView.view2.layer.masksToBounds = false
        headerView.view2.layer.cornerRadius = headerView.view2.frame.height/2
        headerView.view2.clipsToBounds = true
        
        headerView.view3.layer.masksToBounds = false
        headerView.view3.layer.cornerRadius = headerView.view3.frame.height/2
        headerView.view3.clipsToBounds = true
        
        // SET DATA
        headerView.nameLabel.text = User.sharedInstance.fullName

        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: User.sharedInstance.email ?? "",
                                                        attributes: yourAttributes)
        headerView.emailButton.setAttributedTitle(attributeString, for: .normal)
        
        
        //set headerview to tableview
        tableView.tableHeaderView = headerView
        
    }
    
    func loadHeaderData(claims:[Claim]){ // load ME query next time -- David should add this
        if headerView == nil {
            return
        }
        var openCount = 0
        var closedCount = 0
        var assignedToday = 0
        var assigned = 0
        for claim in claims {
            
            assigned+=1
            if claim.status == ClaimStatus.closed {
                closedCount+=1
            }
            if claim.status == .open || claim.status == .active {
                openCount+=1
            }
            let today = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let todayStr = dateFormatter.string(from: today)
            
            if claim.claimDate == todayStr {
                assignedToday+=1
            }
            
            
        }
        
        headerView.claimOpenLbl.text = String(openCount)
        headerView.claimClosedLbl.text = String(closedCount)
        headerView.timeLoggedLbl.text = String(assignedToday)
        headerView.claimAssignedLbl.text = String(assigned)
        
    }
    
    @objc func profilePictureTap(_ sender: UITapGestureRecognizer? = nil) {
        
        ImagePickerManager().pickImage(self) { imageUrl in
            //add image to profile
            
            if let image = UIImage(contentsOfFile: imageUrl.path) {
                
               if User().saveImage(image: image) {
                
                    self.headerView.profileImage.image = image
                }
            }
    
        }
    }
    
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimDetailViewController") as! ClaimDetailViewController
        viewController.claim = claims[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if claims.count > 30{
            return 30
        } else {
            return claims.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell") as! ClaimsTableViewCell
        
        cell.statusLabel.text = "CLOSED"
        cell.statusView.backgroundColor = ColorUtils.getGreenColor()
             
        cell.claimNumberLabel.text = claims[indexPath.row].claimNumber
        cell.claimantNameLabel.text = claims[indexPath.row].claimant?.fullName
        cell.insuredNameLabel.text = claims[indexPath.row].insured?.fullName

        cell.dateLabel.text = claims[indexPath.row].claimDate?.description

        return cell
    }

}
