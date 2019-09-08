//
//  ImageCollectionViewCell.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/8/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 3
        // Initialization code
    }

}
