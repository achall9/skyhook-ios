//
//  ClaimsTableViewCell.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/17/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ClaimsTableViewCell: UITableViewCell {
    
    let BORDER_WIDTH: CGFloat = 1.0
   
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var claimNumView: UIView!
    @IBOutlet weak var flagView: UIView!
    @IBOutlet weak var labelView: UIView!
    @IBOutlet weak var buttonView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        setBorders()
        
    }
    
    func setBorders(){
        self.mainView.layer.borderWidth = BORDER_WIDTH
        self.mainView.layer.borderColor = UIColor.gray.cgColor

//        self.claimNumView.layer.borderWidth = BORDER_WIDTH
//        self.claimNumView.layer.borderColor = UIColor.gray.cgColor
      

        self.labelView.layer.borderWidth = BORDER_WIDTH
        self.labelView.layer.borderColor = UIColor.gray.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
