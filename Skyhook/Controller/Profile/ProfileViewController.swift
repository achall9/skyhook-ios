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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ClaimsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClaimCell")
        
        //set profile headerview to table
        setHeader()

    }
    
    func setHeader(){
        
        headerView = (Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)![0] as! ProfileHeaderView)
        
        //profile image circular
        headerView.profileImage.layer.masksToBounds = false
        headerView.profileImage.layer.cornerRadius = headerView.profileImage.frame.height/2
        headerView.profileImage.clipsToBounds = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.profilePictureTap(_:)))
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
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "daniel@threegriffins.com",
                                                        attributes: yourAttributes)
        headerView.emailButton.setAttributedTitle(attributeString, for: .normal)
        
        //set headerview to tableview
        tableView.tableHeaderView = headerView
        
    }
    
    @objc func profilePictureTap(_ sender: UITapGestureRecognizer? = nil) {
        ImagePickerManager().pickImage(self){ image in
            //add image to profile
            self.headerView.profileImage.image = image
        }
    }
    
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimDetailViewController") as! ClaimDetailViewController
//                viewController.claim = claims[indexPath.row]
        var claim = Claim()
        claim.status = "CLOSED"
        viewController.claim = claim
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell") as! ClaimsTableViewCell
        cell.statusView.backgroundColor = ColorUtils.getGreenColor()
        cell.statusLabel.text = "CLOSED"
        return cell
    }

}
