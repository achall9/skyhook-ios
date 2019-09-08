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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //add subviews
        let compView: CompanyInfoView = .fromNib()
        scrollView.addSubview(compView)
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
