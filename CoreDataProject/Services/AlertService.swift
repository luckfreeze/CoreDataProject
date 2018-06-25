//
//  AlertService.swift
//  CoreDataProject
//
//  Created by lucas.v.moraes on 25/06/2018.
//  Copyright © 2018 LSolutions. All rights reserved.
//

import UIKit

class AlertService {
    
    static func AlertWithAction(in viewController: UIViewController, withMessage message: String, action: @escaping ()->()) {
        
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Okay", style: UIAlertActionStyle.default) { (_) in
            action()
        }
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func DefaultAlert(in viewController: UIViewController, withMessage message: String) {
        let alert = UIAlertController(title: "Warning", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil)
        alert.addAction(okAction)
        viewController.present(alert, animated: true, completion: nil)
    }
}
