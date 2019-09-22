//
//  SettingsTableViewCell.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/18/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nextButton: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        //set circle view
        circleView.layer.masksToBounds = false
        circleView.layer.cornerRadius = circleView.frame.height/2
        circleView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
