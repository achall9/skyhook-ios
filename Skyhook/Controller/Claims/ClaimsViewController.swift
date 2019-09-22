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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set tableview to view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ClaimsTableViewCell", bundle: nil), forCellReuseIdentifier: "ClaimCell")
        
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
//        viewController.claim = claims[indexPath.row]
        var claim = Claim()
        claim.status = "OPEN"
        viewController.claim = claim
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.contentView.layer.masksToBounds = true
        
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClaimCell") as! ClaimsTableViewCell
        if indexPath.row == 0 {
            cell.statusView.backgroundColor = ColorUtils.getRedColor()
            cell.statusLabel.text = "OPEN"

        }
        if indexPath.row > 0 {
            cell.statusView.backgroundColor = ColorUtils.getOrangeColor()
            cell.statusLabel.text = "ACTIVE"
        }
        return cell
    }
    
    

}
