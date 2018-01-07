//
//  Contact.swift
//  CoreDataProject
//
//  Created by Lucas Moraes on 25/12/2017.
//  Copyright © 2017 LSolutions. All rights reserved.
//

import Foundation

struct ContactModel: Contact {
    let name: String
    let email: String
    let age: Int32
    
    init(name: String, email: String, age: Int32) {
        self.name = name
        self.email = email
        self.age = age
    }
}