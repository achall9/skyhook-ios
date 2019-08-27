//
//  ClaimDetailViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/18/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ClaimDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet weak var tableView: UITableView!
    
    var claim: Claim = Claim()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ActivityItemTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityItemTableViewCell")
        
        
        setHeader()
        
    }
    
    
    func setHeader(){
        
        let view = (Bundle.main.loadNibNamed("ClaimHeaderView", owner: self, options: nil)![0] as! ClaimHeaderView)

        claim = Claim()
        claim.id = "12"
   
        view.setViews(claim:claim)

        //set headerview to tableview
        tableView.tableHeaderView = view
        

    }
    
    
    
    @IBAction func goBack(_ sender: Any) {
      self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func addNewActivity(_ sender: Any) {
       let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewActivityViewController") as! NewActivityViewController
        self.present(viewController, animated: false, completion: nil)
    }
    
    
    
    /// *** TABLEVIEW DELEGATE/DATASOURCE MARK *** ///
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //go to claim detail view
        tableView.deselectRow(at: indexPath, animated: false)
     
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ActivityDetailViewController") as! ActivityDetailViewController
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
            let a = Activity()
            cell.activity = a
        }
        if indexPath.row == 1{
            let a = Activity()
            a.time = 30014.00
            cell.activity = a
            cell.timeLabel.text = "01:23:14"
        }
      
//        cell.activity = claim?.activities[indexPath.row]
        
        return cell
    }
    
   
}
