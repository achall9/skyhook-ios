//
//  SettingsViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/15/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
//    let options:[String] = ["Change email","Edit password","Password recovery","Logout"]
    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set tableview to view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")

        // Do any additional setup after loading the view.
    }
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to setting action
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.row == 3 {
            User.sharedInstance.logout()
            self.appDelegate.enterApp(false)
        }
    
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell") as! SettingsTableViewCell
        
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.gray.cgColor
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "Change email"
            cell.icon.image = UIImage(named: "change_email")
        case 1:
            cell.titleLabel.text = "Edit password"
            cell.icon.image = UIImage(named: "edit_pwd")
            break
        case 2:
            cell.titleLabel.text = "Password recovery"
            cell.icon.image = UIImage(named: "edit_pwd")
        default:
            cell.titleLabel.text = "Logout"
            cell.icon.image = UIImage(named: "logout")
            break
        }
        
        
        return cell
    }

    


}
