//
//  ActivityItemTableViewCell.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/22/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

protocol ActivityItemDelegate {
    func didStartActivity()
    func startError()
}

class ActivityItemTableViewCell: UITableViewCell {
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!

    var activity: Activity?
    
    var delegate: ActivityItemDelegate?

    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
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
        if !appDelegate.isTracking {
        
            if let activity = self.activity {
                
                //already started in backend.. allow to stop
                if activity.status == .started {
                    activity.stopTracking(id: activity.id!, flag: "") { result in
                        self.playButton.setImage(UIImage(named:"play_small"), for: .normal)

                    }
                    
                } else if activity.status == .paused {
                     activity.startTracking() { result in
                                   
                        if result {
       
                            self.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
                                 
                            } else {
                                //failed
                                
                        }
                              
                    }
                    
                }
                    
                else {
                    activity.startTracking() { result in
                               
                        if !result {
                            self.delegate?.startError()
                                
                        } else {
                                          
                            self.playButton.setImage(UIImage(named:"stop_small"), for: .normal)
                                
                            //show alert to route to destination on driving activity
                            if let name = activity.name, name.contains("Driv") {
                                self.delegate?.didStartActivity()
        
                            }
                                
                        }
                      
                    }
                }
                
           
              
            }

        }
        // Stop Play
        else {
            
            if appDelegate.activity?.id == self.activity?.id
            {
                activity?.stopTracking(id:activity!.id!, flag:"") { result in
                    self.playButton.setImage(UIImage(named:"play_small"), for: .normal)

                }
            }
            
        }

    }
    
    
    func setTime(time:Int){
        timeLabel.text = timeString(time: time) // set time to label
    }
    
    //called from timer
    @objc private func updateTime(){
        
        let seconds = activity!.totalElapsedMillis
        timeLabel.text = timeString(time: seconds) // set time to label
        
    }
    
    
    func timeString(time:Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i" , hours, minutes, seconds)
    }
    


    
}
