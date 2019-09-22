//
//  AlertHelper.swift
//  Skyhook
//
//  Created by Alexander Hall on 2019/9/18.
//  Copyright © 2019 Alexander Hall. All rights reserved.
//

import Foundation
import UIKit


typealias AlertActionCallback = (UIAlertAction)  -> Void

class AlertHelper {
    
    static func  showAlert (parent:UIViewController,  title: String, message: String, buttonText: String){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default,handler: nil))
        
        parent.present(alertController, animated: true, completion: nil)
    }
    
    
    static func  showAlertWithCallback (parent:UIViewController,  title: String, message: String, buttonText: String,  onCompletion: @escaping AlertActionCallback){
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: buttonText, style: UIAlertAction.Style.default,handler: onCompletion))
        
        parent.present(alertController, animated: true, completion: nil)
    }
    
    
}
