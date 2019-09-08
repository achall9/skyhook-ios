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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ClaimsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClaimCell")
        
        //set profile headerview to table
        setHeader()

    }
    
    func setHeader(){
        
        let view = (Bundle.main.loadNibNamed("ProfileHeaderView", owner: self, options: nil)![0] as! ProfileHeaderView)
        
        //profile image circular
        view.profileImage.layer.masksToBounds = false
        view.profileImage.layer.cornerRadius = view.profileImage.frame.height/2
        view.profileImage.clipsToBounds = true
        
        // grid views
        view.view0.layer.masksToBounds = false
        view.view0.layer.cornerRadius = view.view0.frame.height/2
       view.view0.clipsToBounds = true

       view.view1.layer.masksToBounds = false
        view.view1.layer.cornerRadius = view.view1.frame.height/2
        view.view1.clipsToBounds = true

        view.view2.layer.masksToBounds = false
        view.view2.layer.cornerRadius = view.view2.frame.height/2
       view.view2.clipsToBounds = true

       view.view3.layer.masksToBounds = false
       view.view3.layer.cornerRadius = view.view3.frame.height/2
       view.view3.clipsToBounds = true
        
        let yourAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15),
            .foregroundColor: UIColor.blue,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: "daniel@threegriffins.com",
                                                        attributes: yourAttributes)
        view.emailButton.setAttributedTitle(attributeString, for: .normal)
        
        //set headerview to tableview
        tableView.tableHeaderView = view
        
    }
    
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
        
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ClaimDetailViewController") as! ClaimDetailViewController
        //        viewController.claim = claims[indexPath.row]
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
