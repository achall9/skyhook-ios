//
//  ActivityItemTableViewCell.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/22/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit


class ActivityItemTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!

    var activity: Activity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateTime),
            name: NSNotification.Name(rawValue: Notifications.UPDATE_TIMER),
            object: nil)
        
        // Initialization code
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1.0
        
    }
    
    @IBAction func clickPlay(_ sender: Any?) {
        // Begin Play
        if playButton.currentImage == UIImage(named:"play_small") {
        
            if let activity = self.activity{
                
                playButton.setImage(UIImage(named:"stop_small"), for: .normal)

                activity.startTracking()
              
            }
       

        }
        // Stop Play
        else {
            
            activity?.stopTracking()
            playButton.setImage(UIImage(named:"play_small"), for: .normal)
            
        }

    }
    
    
    //called from timer
    @objc private func updateTime(){
        
        let seconds = activity!.time
        timeLabel.text = timeString(time: seconds)
        
    }
    
    func timeString(time:TimeInterval) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i" , hours, minutes, seconds)
    }


    
}
