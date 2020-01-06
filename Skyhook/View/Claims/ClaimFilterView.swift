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
    
    @IBOutlet weak var button0: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    
    func setBorders(){
        button0.layer.borderColor = UIColor.lightGray.cgColor
        button0.layer.borderWidth = 1.0
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button1.layer.borderWidth = 1.0
        
        
    }
    @IBAction func filter0(_ sender: Any) {
        delegate?.didClickFilter(value: 0)

    }
    @IBAction func filter1(_ sender: Any) {
        delegate?.didClickFilter(value: 1)
    }
    
    
}
