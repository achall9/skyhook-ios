//
//  NoActivityPlaceHolderView.swift
//  Skyhook
//
//  Created by Alex Hall on 12/11/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import Foundation
import UIKit

protocol CreateActivityDelegate {
    func didCreateActivity()
}




class NoActivityPlaceHolderView : UIView {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    //handle click on claim detail controller
    var delegate: CreateActivityDelegate?

    //clicked button
    @IBAction func createActivityClick(_ sender: Any) {
        
        delegate?.didCreateActivity()
    
    }
}
