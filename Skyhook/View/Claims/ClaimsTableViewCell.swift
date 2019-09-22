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
    
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add shadow on cell
        mainView.backgroundColor = .clear // very important
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOpacity = 0.20
        mainView.layer.shadowRadius = 3
        mainView.layer.shadowOffset = CGSize(width: 0, height: 0)
        mainView.layer.shadowColor = UIColor.black.cgColor
        
        // add corner radius on `contentView`
        mainView.backgroundColor = .white
        mainView.layer.cornerRadius = 3
        
//        setBorders()
        
    }
    
    func setBorders(){
//        self.mainView.layer.borderWidth = BORDER_WIDTH
//        self.mainView.layer.borderColor = UIColor.gray.cgColor

//        self.claimNumView.layer.borderWidth = BORDER_WIDTH
//        self.claimNumView.layer.borderColor = UIColor.gray.cgColor
      

//        self.labelView.layer.borderWidth = BORDER_WIDTH
//        self.labelView.layer.borderColor = UIColor.gray.cgColor

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
