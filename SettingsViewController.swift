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
            cell.nextButton.alpha = 0.0
            break
        }
        
        
        return cell
    }

    


}
