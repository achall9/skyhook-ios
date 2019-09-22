//
//  MainViewController.swift
//  Skyhook
//
//  Created by Alexander Hall on 8/14/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var controllerView: UIView!
    @IBOutlet var tabButtons: [UIButton]!
    
    var prevBtn: Int = 0
    var viewCons: [UIViewController?]!
    
//    let normal_icons: [String] = ["gray_challenge.png", "gray_leaderboard.png", "gray_camera.png", "gray_tenure.png"]
//    let active_icons: [String] = ["challenge-active.png", "leaderboard-active.png", "upload-active.png", "validate-active.png"]
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let claimsVC = self.storyboard?.instantiateViewController(withIdentifier: "ClaimsViewController") as! ClaimsViewController
        let notificationsVC = self.storyboard?.instantiateViewController(withIdentifier: "NotificationsViewController") as! NotificationsViewController
        let settingsVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
//        self.prevBtn = self.appDelegate.selected_viewcon
        
        self.viewCons = [claimsVC, notificationsVC, settingsVC, profileVC]
        self.tabClick(tabButtons[prevBtn])
    }
    
    @IBAction func tabClick(_ sender: UIButton) {
        if self.viewCons![sender.tag] != nil {
//            self.tabImgs[prevBtn - 100].image = UIImage(named: normal_icons[prevBtn - 100])
            let previousVC = self.viewCons[prevBtn ]!
            let newVC = self.viewCons![sender.tag]!
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            addChild(newVC)
//            if newVC is AllBuildsVC && self.appDelegate.show_val_tutorial && self.tutorial_view == nil {
//                self.tutorial_view = TutorialView(frame: self.view.frame)
//                self.view.addSubview(tutorial_view!)
//            }
            self.prevBtn = sender.tag
//            self.tabImgs[prevBtn - 100].image = UIImage(named: active_icons[prevBtn - 100])
            self.animateFadeDismissTransition(to: newVC)
        }
    }
    
    //    @IBAction func actionTab(_ sender: UIButton) {
//        if self.viewCons[sender.tag - 100] != nil && (Employee.sharedInstance.logged_in || sender.tag == 103) {
//            self.tabImgs[prevBtn - 100].image = UIImage(named: normal_icons[prevBtn - 100])
//            let previousVC = self.viewCons[prevBtn - 100]!
//            let newVC = self.viewCons[sender.tag - 100]!
//            previousVC.willMove(toParent: nil)
//            previousVC.view.removeFromSuperview()
//            previousVC.removeFromParent()
//            addChild(newVC)
//            if newVC is AllBuildsVC && self.appDelegate.show_val_tutorial && self.tutorial_view == nil {
//                self.tutorial_view = TutorialView(frame: self.view.frame)
//                self.view.addSubview(tutorial_view!)
//            }
//            self.prevBtn = sender.tag
//            self.tabImgs[prevBtn - 100].image = UIImage(named: active_icons[prevBtn - 100])
//            self.animateFadeDismissTransition(to: newVC)
//        }
//    }
    
    func animateFadeDismissTransition(to newVC: UIViewController) {
        newVC.view.frame = self.controllerView.bounds
        self.controllerView.alpha = 0.0
        self.controllerView.addSubview(newVC.view)
        DispatchQueue.main.async {
            newVC.didMove(toParent: self)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.controllerView.alpha = 1.0
            }, completion: { (finished: Bool) in
                
            })
        }
    }
    
    
    
}
