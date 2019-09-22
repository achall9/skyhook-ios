//
//  ClaimInfoViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/3/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ClaimInfoViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let compView: CompanyInfoView = .fromNib()
            compView.frame = CGRect(x: 15 , y: 10, width: self.scrollView.frame.width-30, height: compView.frame.height)
            compView.layer.cornerRadius = 3
            compView.layer.borderWidth = 1.0
            compView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.addSubview(compView)
        
            let contactView: ContactInfoView = .fromNib()
            contactView.frame = CGRect(x: 15 , y: compView.frame.height + 20, width: self.scrollView.frame.width-30, height: contactView.frame.height)
            contactView.layer.cornerRadius = 3
            contactView.layer.borderWidth = 1.0
            contactView.layer.borderColor = UIColor.lightGray.cgColor
            containerView.addSubview(contactView)
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
