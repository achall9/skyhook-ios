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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var activity: Activity?
    var images:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        activity = Activity()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateTime),
            name: NSNotification.Name(rawValue: Notifications.UPDATE_TIMER),
            object: nil)
        
        setCollectionView(collection: collectionView)
        
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func playButtonClick(_ sender: Any) {
        if playButton.currentImage == UIImage(named:"play_large") {
//            if let activity = self.activity{
                playButton.setImage(UIImage(named:"stop_large"), for: .normal)
                activity!.startTracking()
//            }
        }
            // Stop Play
        else {
            activity?.stopTracking()
            playButton.setImage(UIImage(named:"play_large"), for: .normal)
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
    
    
    
    @IBAction func attachPhoto(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            //add image to activity
            print("IMAGE SET")
            self.images.append(image)
            self.collectionView.reloadData()
        }
    }
    

}


extension ActivityDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
   
    func setCollectionView(collection: UICollectionView) {
        collection.backgroundColor = UIColor.clear//Colors.app_tableview_background.generateColor()
        collection.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.activity.images.count
        return self.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //view image full screen
        print("CLICKED")
    }

    
}
