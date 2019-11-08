//
//  ClaimFilterView.swift
//  Skyhook
//
//  Created by Alexander Hall on 10/24/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit


protocol FilterClickDelegate {
    func didClickFilter(value:Int)

}
class ClaimFilterView: UIView {

    var delegate: FilterClickDelegate?
    
    @IBOutlet weak var allButton: UIButton!
    
    @IBOutlet weak var openButton: UIButton!
 
     @IBOutlet weak var activeButton: UIButton!
    
    func setBorders(){
        openButton.layer.borderColor = UIColor.lightGray.cgColor
        openButton.layer.borderWidth = 1.0
        
        activeButton.layer.borderColor = UIColor.lightGray.cgColor
        activeButton.layer.borderWidth = 1.0
        
        allButton.layer.borderColor = UIColor.lightGray.cgColor
               allButton.layer.borderWidth = 1.0
        
        
    }
    @IBAction func filterOpen(_ sender: Any) {
        delegate?.didClickFilter(value: 0)
        
    }
    
    @IBAction func filterActive(_ sender: Any) {
        delegate?.didClickFilter(value: 1)

    }
    
    @IBAction func filterAll(_ sender: Any) {
        delegate?.didClickFilter(value: -1)

    }
    
    
}
