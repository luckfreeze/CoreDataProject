//
//  CustomButton.swift
//  CoreDataProject
//
//  Created by Lucas Moraes on 20/12/2017.
//  Copyright © 2017 LSolutions. All rights reserved.
//

import UIKit

var isRounded = false

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var cornerR: Bool {
        get { return isRounded }
        set {
            isRounded = newValue
            if isRounded == true {
                self.layer.cornerRadius = self.frame.height/2
            } else {
                self.layer.cornerRadius = 0
            }
        }
    }
}
