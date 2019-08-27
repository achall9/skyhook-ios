//
//  ActivityDetailViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/22/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var attachPhotoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func playButtonClick(_ sender: Any) {
        if playButton.currentImage == UIImage(named:"play_large") {

//            if let activity = self.activity{
                playButton.setImage(UIImage(named:"stop_small"), for: .normal)
//                activity.startTracking()
//            }

        }
            // Stop Play
        else {

//            activity?.stopTracking()
            playButton.setImage(UIImage(named:"play_large"), for: .normal)

        }

        
    }
    
    @IBAction func attachPhoto(_ sender: Any) {
    }
    

}
