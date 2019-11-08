//
//  File.swift
//  Skyhook
//
//  Created by Alexander Hall on 9/4/19.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

// CUSTOM COLOR PARSE CLASS //

import Foundation
import UIKit

class  ColorUtils {
    
    
    static func getRedColor() -> UIColor {
        
        return UIColor(red: 230/255, green: 0/255, blue: 38/255, alpha: 1.0)
        
    }
    
    static func getOrangeColor() -> UIColor {
       
        return UIColor(red: 255/255, green: 165/255, blue: 0/255, alpha: 1.0)
        
    }
    
    static func getGreenColor() -> UIColor {
        
        return UIColor(red: 0/255, green: 128/255, blue: 0/255, alpha: 1.0)

    }
    
    static func getPurpleColor() -> UIColor {
        
         return UIColor(red: 122/255, green: 129/255, blue: 255/255, alpha: 1.0)
         
     }
    
    
    

    
    
    //    static func getGradient ()  -> CAGradientLayer{
    //        var gl:CAGradientLayer!
    //
    //          let colorTop = UIColor(red: 255 /255, green: 255/255, blue: 255/255, alpha: 0.0).cgColor
    //
    //        let colorBottom = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor
    //
    //
    //        gl = CAGradientLayer()
    //        gl.colors = [colorTop, colorBottom]
    //        gl.locations = [0.0, 1.0]
    //
    //        return gl
    //    }
    
}
