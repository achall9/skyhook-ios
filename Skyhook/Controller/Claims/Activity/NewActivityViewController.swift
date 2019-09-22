//
//  NewActivityViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/19/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class NewActivityViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var activityNameField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var section: [ActivitySection] = []
    
    var claim: Claim?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityTableViewCell")
        tableView.register(UINib(nibName: "ActivitySectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ActivitySectionHeaderView")
        
    }

    
    @IBAction func goBack(_ sender: Any) {
       
        self.navigationController?.popViewController(animated: false)
    }
    
    
    // Show text field input for custom activity
    func allowCustomActivity(){
        viewSlideInFromTopToBottom(view: tableView)
        tableView.alpha = 0.0
        
        activityNameField.becomeFirstResponder()
        activityNameField.setLeftPaddingPoints(10)
        activityNameField.setRightPaddingPoints(10)
        
        activityNameField.layer.borderColor = UIColor.lightGray.cgColor
        activityNameField.layer.borderWidth = 1.0
    }
    
    //MARK: Slide View - Top To Bottom
    func viewSlideInFromTopToBottom(view: UIView) -> Void {
        let transition:CATransition = CATransition()
        transition.duration = 0.7
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.layer.add(transition, forKey: kCATransition)
        
    }
    
    
    // officially create activity after input into text field
    @IBAction func createNewActivity(_ sender: Any) {
        if activityNameField.text == "" {
            //no input, don't allow
            return
        }
        createActivity()
        
    }

    
    func createActivity(){
        
        //go to claim view and show new acitvities added
        self.navigationController?.popViewController(animated: false)

    }
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///
    
    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.section.count
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "ActivitySectionHeaderView" ) as! ActivitySectionHeaderView
        switch(section) {
        case 0:
            headerView.label.text = "CLAIMANT"
            break
        case 1:
            headerView.label.text = "INSURED"
            break
        default:
            headerView.label.text = "OTHER"
            break
        }
        
//        headerView.label.text = self.section[section]
        
        return headerView

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.section[section].activities.count
        switch(section) {
        case 0:
            return 4
        case 1:
            return 4
        default:
            return 6
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityTableViewCell") as! ActivityTableViewCell
        
        //UNTIL API IS READY -- HARDCODED :/
        switch(indexPath.section) {
        case 0:
            if indexPath.row == 0 {
                cell.label.text = "First Contact"
            }
            if indexPath.row == 1 {
                cell.label.text = "Drive To Destination"
            }
            if indexPath.row == 2 {
                cell.label.text = "Met With"
            }
            if indexPath.row == 3 {
                cell.label.text = "Return Driving"
            }
            break
        case 1:
            
            if indexPath.row == 0 {
                cell.label.text = "First Contact"
            }
            if indexPath.row == 1 {
                cell.label.text = "Drive To Destination"
            }
            if indexPath.row == 2 {
                cell.label.text = "Met With"
            }
            if indexPath.row == 3 {
                cell.label.text = "Return Driving"
            }
            break
            
        default:
            if indexPath.row == 0 {
                cell.label.text = "First Contact"
            }
            if indexPath.row == 1 {
                cell.label.text = "Drive To Destination"
            }
            if indexPath.row == 2 {
                cell.label.text = "Met With"
            }
            if indexPath.row == 3 {
                cell.label.text = "Scene Investigation / Documentation of Scene"
            }
            if indexPath.row == 4 {
                cell.label.text = "Return Driving"
            }
            if indexPath.row == 5 {
                cell.label.text = "Other"
            }
            
            break
        }
        
//         cell.label.text = self.section[indexPath.section].activities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if indexPath.section == 2 && indexPath.row == 5 { // set custom activity
            allowCustomActivity()
        }
        else {
            
            //add activty to claim, go back to claim view
            createActivity()
        }
    }
    
}
