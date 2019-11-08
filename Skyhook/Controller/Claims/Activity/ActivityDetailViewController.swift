//
//  ActivityDetailViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/22/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ActivityDetailViewController: BaseViewController, UITextViewDelegate {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var addedNotesTextView: UITextView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var attachPhotoLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
        
    var images:[UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.updateTime),
            name: NSNotification.Name(rawValue: Notifications.UPDATE_TIMER),
            object: nil)
                                        
        
        hideKeyboardWhenTappedAround()
      
        setCollectionView(collection: collectionView)
        
        //set title
        self.titleLabel.text = claim!.activities[selectedIndex!].name ?? "Activity Detail"
        
        //set notes, images and time
        self.textView.delegate = self // for placeholder mimic
        textView.text = "Enter notes here"
        textView.textColor = UIColor.lightGray
        if claim?.activities[selectedIndex!].status == .complete {
            textView.isEditable = false
            
        }
        
        
        if self.claim?.activities[selectedIndex!].notes == "" {
            self.addedNotesTextView.alpha = 0.0
        } else {
            self.addedNotesTextView.text = self.claim?.activities[selectedIndex!].notes
        }
        
        if self.images.count > 0 {
            self.attachPhotoLabel.alpha = 0.0
            //set the images..
        }
        
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //active activity
        if appDelegate.isTracking && appDelegate.activity?.id == claim!.activities[selectedIndex!].id {
            
            self.playButton.setImage(UIImage(named:"stop_large"), for: .normal)
            self.timeLabel.text = timeString(time:appDelegate.activity!.totalElapsedMillis)
            
        } else {
             self.timeLabel.text = timeString(time:(self.claim?.activities[selectedIndex!].totalElapsedMillis)!)
        }
             
        if claim?.activities[selectedIndex!].status == .complete {
            playButton.alpha = 0.0
        }
    }
    
    
    @IBAction func finishActivity(_ sender: Any) {
//        Activity().updateStop(activityId:(self.claim?.activities[selectedIndex!].id)!) { result in
//            //success
//            self.navigationController?.popViewController(animated: false)
//        }
    }
    
//    func textViewShouldReturn(_ textField: UITextField) -> Bool {
//          print("SEND CLICK")
//          updateNotes()
//          return true
//      }


    
    
    // DELEGATE METHODS FOR PLACEHOLDER MIMIC
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter notes here"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    
    @IBAction func goBack(_ sender: Any) {
        if textView.text! != "" && textView.text! != "Enter notes here" && claim!.activities[selectedIndex!].notes != textView.text {
            //text updated -- update server
            updateNotes()
            self.navigationController?.popViewController(animated: false)

       } else {
            self.navigationController?.popViewController(animated: false)
        }
    }
    
    func updateNotes(){
        
        Activity().updateNotes(activityId: claim!.activities[selectedIndex!].id!, notes: textView.text!) { result in
                //update activity locally and exit view
                if result {
                    let newNotes = "\(self.claim!.activities[self.selectedIndex!].notes)\n\(self.textView.text!)"
                    self.claim!.activities[self.selectedIndex!].notes = newNotes
                    
                    self.textView.text = ""
                    self.addedNotesTextView.text = self.claim!.activities[self.selectedIndex!].notes

                } else {
                    // Failed...
                    self.showError(message:"Failed to update notes.")
                }
            }
        
    }
    
    
    @IBAction func playButtonClick(_ sender: Any) {
        if !appDelegate.isTracking {
          
            self.claim!.activities[self.selectedIndex!].startTracking() { result in
                
                if result {
                    self.playButton.setImage(UIImage(named:"stop_large"), for: .normal)
                } else {
                    self.showError(message:"This activity has been finished already. Please create a new one to begin tracking.")
                }
            }
        }
            // Stop Play
        else {
            
            if textView.text! != "" && textView.text! != "Enter notes here" && claim!.activities[selectedIndex!].notes != textView.text {
                updateNotes()
            }
            if self.claim!.activities[self.selectedIndex!].id == appDelegate.activity?.id {
                self.appDelegate.activity?.pauseTracking(id:self.appDelegate.activity!.id!, pause:true, flag:"") { result in
                    
                    self.playButton.setImage(UIImage(named:"play_large"), for: .normal)

                }
            }
          
        }

        
    }
    
    
    
    //called from timer
    @objc private func updateTime(){
        
        if appDelegate.isTracking && appDelegate.activity?.id == claim!.activities[selectedIndex!].id {
        
            let seconds = appDelegate.activity?.totalElapsedMillis
            timeLabel.text = timeString(time: seconds!)
        }
        
    }
    
    func timeString(time:Int) -> String {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i" , hours, minutes, seconds)
    }
    
    
    
    @IBAction func attachPhoto(_ sender: Any) {
        ImagePickerManager().pickImage(self){ imageURL in
            //add image to activity
            
            if let image = UIImage(contentsOfFile: imageURL.path) {
                self.attachPhotoLabel.alpha = 0.0
                self.images.append(image)
                self.collectionView.reloadData()
            }

            
            // Create the file to upload
//            guard
//              let fileURL = Bundle.main.url(forResource: "a",
//                                            withExtension: "txt"),
//              let file = GraphQLFile(fieldName: "file",
//                                     originalName: "a.txt",
//                                     mimeType: "text/plain", // <-defaults to "application/octet-stream"
//                                     fileURL: fileURL) else {
//                // Either the file URL couldn't be created or the file couldn't be created.
//                return
//            }
            
            self.uploadImage(path: imageURL.absoluteString)
            
        }
    }
    
    func uploadImage(path:String) {
        self.claim!.activities[self.selectedIndex!].uploadFile(activityId: self.claim!.activities[self.selectedIndex!].id!, file: path) { result in
            
            if result {
//                self.images.append(image)
                self.collectionView.reloadData()

            } else {
                self.showError(message: "Image upload failed. Please try again later.")
            }
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
